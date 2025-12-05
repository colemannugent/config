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

# Enable mise-en-place
mise activate fish | source

# Setup path
set -gx PATH /opt/homebrew/bin $PATH
set -gx GOPATH $HOME/src/go
set -gx PATH $HOME/src/go/bin $PATH
set -gx PATH $HOME/.cargo/bin $PATH

set -gx EDITOR (which nvim)

# Make SSH use 1Password
# set -x SSH_AUTH_SOCK ~/.1password/agent.sock

# Setup AI env variables
set -x OPENROUTER_API_KEY "op://Employee/OpenRouter/Aider Key"
set -x OPENAI_API_KEY "op://Employee/OpenAI/Aider Key"
set -x OLLAMA_API_BASE "http://localhost:11434"
