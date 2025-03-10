# Non-interactive users (sshy, sync)
if not status --is-interactive
	exit # Skips the rest of this file, not exiting the shell
end

# Set XDG variables
set -x XDG_CONFIG_HOME $HOME'/.config'
set -x XDG_CACHE_HOME $HOME'/.cache'
set -x XDG_DATA_HOME $HOME'/.local/share'

# Setup asdf
set -x ASDF_CONFIG_FILE "$XDG_CONFIG_HOME/asdf/asdfrc"
set -x ASDF_DATA_DIR "$XDG_DATA_HOME/asdf"
set -x ASDF_GEM_DEFAULT_PACKAGES_FILE "$XDG_DATA_HOME/gem/default-gems"
source "$XDG_CONFIG_HOME/asdf/asdf.fish"

# Set default editor to nvim
set -x EDITOR (which nvim)
set -x VISUAL $EDITOR

# Add colors to ls and friends
if test -e /usr/bin/dircolors -a -e ~/.config/dircolors
	eval (dircolors -c ~/.config/dircolors)
	alias ls 'ls --color=auto'
	alias grep 'grep --color=auto'
	alias fgrep 'fgrep --color=auto'
	alias egrep 'egrep --color=auto'
end

set -x GOPATH ~/src/go
set -gx PATH ~/src/go/bin $PATH
set -gx PATH ~/.cargo/bin $PATH
set -gx PATH $ASDF_DATA_DIR/shims $PATH

# Make SSH use 1Password
# set -x SSH_AUTH_SOCK ~/.1password/agent.sock

