# Non-interactive users (sshy, sync)
if not status --is-interactive
	exit # Skips the rest of this file, not exiting the shell
end

# Set XDG variables
set -x XDG_CONFIG_HOME $HOME'/.config'
set -x XDG_CACHE_HOME $HOME'/.cache'
set -x XDG_DATA_HOME $HOME'/.local/share'

# Add colors to ls and friends
if test -e /usr/bin/dircolors -a -e ~/.config/dircolors
	eval (dircolors -c ~/.config/dircolors)
	alias ls 'ls --color=auto'
	alias grep 'grep --color=auto'
	alias fgrep 'fgrep --color=auto'
	alias egrep 'egrep --color=auto'
end

# Setup path
set -gx --prepend PATH $HOME/.asdf/shims $PATH
set -gx GOPATH $HOME/src/go
set -gx PATH $HOME/src/go/bin $PATH
set -gx PATH $HOME/.cargo/bin $PATH

# Make SSH use 1Password
# set -x SSH_AUTH_SOCK ~/.1password/agent.sock

