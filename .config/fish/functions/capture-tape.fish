function capture-tape
    # Tape capture with auto-stop on blank+silence and SIGINT forwarding

    # Parameters
    set -l label (string trim -- "$argv[1]")
    if test -z "$label"
        set label "tape_"(date "+%Y%m%d_%H%M%S")
    end

    set -l out "$label.mp4"
    set -l log "$label.log"

    # Watchdog settings
    set -l blank_seconds 30   # seconds of continuous blank+silence before stop
    set -l arm_delay 5        # seconds to wait before arming watchdog

    # ffmpeg PID placeholder
    set -g pid 0

    # SIGINT handler: forward Ctrl-C to ffmpeg
    function __on_sigint --on-signal SIGINT
        if test $pid -gt 0
            echo "\n⏹ Interrupted — stopping ffmpeg (pid=$pid)…"
            kill -INT $pid
        end
        exit 1
    end

    echo "▶ Capturing '$label' → $out"
    echo "  Log → $log"

    # Launch ffmpeg in background
    ffmpeg -nostdin -hide_banner \
        -init_hw_device vaapi=vaapi:/dev/dri/renderD128 \
        -filter_hw_device vaapi \
        -thread_queue_size 512 -f v4l2 -input_format yuyv422 -video_size 720x480 -i /dev/video0 \
        -thread_queue_size 512 -f alsa -i hw:2,0 \
        -vf "yadif=mode=1:parity=0,blackdetect=d=2:pix_th=0.07,format=nv12,hwupload=vaapi" \
        -af "silencedetect=n=-50dB:d=2" \
        -c:v h264_vaapi -qp 20 -rc_mode VBR -b:v 8M -maxrate 12M -bufsize 16M -quality 1 \
        -c:a aac -b:a 128k \
        -y $out 2>>$log &
    set pid $last_pid

    # Quick sanity check
    sleep 1
    if not test -s $log
        echo "❌ ffmpeg failed to start — check $log"
        return 1
    end

    # Give user time to press PLAY
    echo "⏳ Waiting $arm_delay s before arming watchdog…"
    sleep $arm_delay

    # Polling watchdog for blank+silence
    set -l black_start -1
    set -l silence_start -1

    while kill -0 $pid
        # Read new lines from log
        for line in (tail -n +1 $log)
            switch $line
                case '*black_start*'
                    set black_start (date +%s)
                case '*black_end*'
                    set black_start -1
                case '*silence_start*'
                    set silence_start (date +%s)
                case '*silence_end*'
                    set silence_start -1
            end
        end

        if test $black_start -ge 0 -a $silence_start -ge 0
            set -l now (date +%s)
            if test (math "$now - $black_start") -gt $blank_seconds -a \
                    (math "$now - $silence_start") -gt $blank_seconds
                echo "⏹ Detected $blank_seconds s of blank+silence — stopping."
                kill -INT $pid
                break
            end
        end
        sleep 1
    end

    # Wait for ffmpeg to exit
    wait $pid
    if test $status -ne 0
        echo "❌ ffmpeg exited with error — see $log"
        return 1
    end

    echo "✔ Finished '$label' (size: "(du -h $out | cut -f1)")"
end

