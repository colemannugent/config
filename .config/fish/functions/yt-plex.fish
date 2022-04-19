# Defined in /tmp/fish.T3lH3N/yt-plex.fish @ line 2
function yt-plex
	pushd /storage/share/YouTube/
	~/.local/bin/yt-dlp \
	-f bestvideo+bestaudio/best \
	--merge-output-format mkv \
	# Resume in-progress downloads
	--continue \
	--ignore-errors \
	--no-overwrites \
	--all-subs \
	--embed-subs \
	--add-metadata \
	--write-annotations \
	--download-archive "log.txt" \
	-o "%(uploader)s/%(title)s.%(ext)s" \
	--sleep-interval 2 \
	--batch-file=/storage/share/YouTube/channel_list.txt
	popd
	#--external-downloader aria2c \
	#--external-downloader-args '-c -j 8 -x 5 -s 10 -k 10M' \
	#--dateafter now-2weeks \
end
