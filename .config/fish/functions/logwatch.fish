function logwatch
	set container_name falco-app-1
	set interval 1

	function on_interrupt --on-signal SIGINT
		echo "\nStopping log watcher."
		exit 0
	end

	while true
		set container_status (docker ps --filter name=$container_name --format '{{.Names}}')

		if test "$container_status" = "$container_name"
			docker logs -f $container_name -n 0
		end

		sleep $interval
	end

end
