function ts
	tmux new-session -d -s falco-dev -n dev -c ~/src/Falco/
	tmux new-window -d -t '=falco-dev' -n runner -c ~/src/Falco/
	tmux send-keys -t '=falco-dev:=runner' 'dcu' Enter
	tmux new-window -d -t '=falco-dev' -n logs -c ~/src/Falco/
	tmux send-keys -t '=falco-dev:=logs' 'grc tail -f log/production.log' Enter
	tmux new-window -d -t '=falco-dev' -c ~/src/Falco/
	docker run --privileged -d -p 389:389 rroemhild/test-openldap
	tmux attach
end

