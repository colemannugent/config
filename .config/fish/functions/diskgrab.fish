function diskgrab
	##############  CONFIGURE TO SUIT  ##############
	set DEST_ROOT $HOME/Discs          # Where copies are stored
	set DEVICE     /dev/sr0            # Your optical drive
	#################################################

	mkdir -p -- "$DEST_ROOT"

	#
	#‑‑‑ Ctrl‑C handling ‑‑‑
	#
	#  We install a *global* flag that the signal‑handler sets.
	#  The main loop checks that flag and breaks cleanly instead
	#  of letting SIGINT kill the whole shell.
	#
	set -g __copy_discs_abort 0
	function __copy_discs_sigint --on-signal SIGINT
		echo
		echo "⚠️  Interrupted – stopping copy_discs"
		set -g __copy_discs_abort 1
	end

	#
	#‑‑‑ Main loop ‑‑‑
	#
	while test $__copy_discs_abort -eq 0
		# Prompt for a label
		read -P "Enter disk label (or q to quit): " label
		if test -z "$label" -o "$label" = "q"
			break
		end
		if test $__copy_discs_abort -ne 0
			break
		end
		eject -t
		echo "📀 Waiting for disc to be ready…"
		sleep 30

		set dest "$DEST_ROOT/$label"
		if test -e "$dest"
			read -P "'$label' exists. Overwrite? [y/N]: " confirm
			if not string match -rq '^[Yy]' -- "$confirm"
				continue
			end
			rm -rf -- "$dest"
		end
		mkdir -p -- "$dest"

		# Detect whether the disc is already mounted
		set mp (findmnt -n -o TARGET -- "$DEVICE")
		if test -n "$mp"
			echo "📀 Already mounted at '$mp'"
		else
			echo "📀 Mounting $DEVICE…"
			if not udisksctl mount -b "$DEVICE" >/dev/null 2>&1
				echo "❌ Failed to mount $DEVICE"
				continue
			end
			set mp (findmnt -n -o TARGET -- "$DEVICE")
			if test -z "$mp"
				echo "❌ Could not determine mount‑point"
				continue
			end
		end

		echo "➡️  Copying from '$mp' → '$dest'…"
		rsync -ahhhHv --secluded-args --progress "$mp/" "$dest/"

		echo "⏏️  Unmounting $DEVICE…"
		udisksctl unmount -b "$DEVICE"
		eject

		notify-send "Disk copy complete" "Label: $label"
		echo "✅ Finished ‘$label’. Insert next disc (Ctrl‑C to stop)."
	end

	#
	#‑‑‑ Cleanup: remove handler & flag so they don’t affect other code
	#
	functions -e __copy_discs_sigint
	set -e __copy_discs_abort
	echo "👋 copy_discs finished."
	return
end
