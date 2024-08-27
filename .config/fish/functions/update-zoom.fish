function update-zoom
	mkdir /tmp/zoom
	pushd /tmp/zoom
	wget "https://zoom.us/client/latest/zoom_amd64.deb"
	sudo dpkg -iE zoom_amd64.deb
	popd
	rm -rf /tmp/zoom
end
