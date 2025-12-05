function capture-simple
	read -P 'Tape label: ' label
	set label (string trim -- "$label")
	if test -z "$label"
		set label "tape_"(date "+%Y%m%d_%H%M%S")
	end

	ffmpeg -hide_banner \
	-thread_queue_size 1024 -f v4l2 -input_format yuyv422 -video_size 720x480 -i /dev/video0 \
	-thread_queue_size 1024 -f alsa -i hw:2,0 \
	-vf "yadif=mode=1" \
	-af "silencedetect=n=-50dB:d=15" \
	-c:v libx264 -preset fast -crf 18 \
	-c:a aac -b:a 128k \
	-map 0:v -map 1:a \
	-f tee "[f=mp4]$label.mp4|[f=mpegts]udp://127.0.0.1:1234?pkt_size=1316"
end
