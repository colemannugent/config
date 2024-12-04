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

# Make vim know where everything is
# set -x VIMINIT 'let $MYVIMRC="$XDG_CONFIG_HOME/vim/vimrc" | source $MYVIMRC'

# Setup GOPATH and add go bin to PATH
set -x GOPATH ~/src/go
set -gx PATH ~/src/go/bin $PATH

# Add Cargo bin to path
set -gx PATH ~/.cargo/bin $PATH

# Make SSH use 1Password
# set -x SSH_AUTH_SOCK ~/.1password/agent.sock

# apt-get and aptitude
alias uu "sudo apt update && sudo apt upgrade -y && sudo apt autoremove"
alias ai "sudo apt install"
alias alu "sudo apt list --upgradeable"
alias ar "sudo apt remove"
alias aar "sudo apt-get autoremove"
alias acs "sudo apt-cache search"

# Editor shortcuts
alias v "$EDITOR -p"
alias vf "$EDITOR (fzf)"
alias sv "sudoedit"
alias note "$EDITOR \"(date +\"%A, %B %e %Y\")\".md"

# VSCode
alias c "code"

# Ranger
alias r "ranger"

# Git
alias gl "git log --color --graph --pretty=format:\"%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr)%C(bold blue) <%an %GK> %Creset\" --abbrev-commit"
alias ga "git add"
alias gc "git commit --verbose"
alias gd "git diff"
alias gs "git status"
alias grc "git rebase --continue"
alias gte "git log --oneline --since=12hours --pretty=format:\"- %s\""

# Docker
alias d "docker"
alias db "docker build"
alias de "docker exec -it"
alias dp "docker pull"
alias dspa "docker system prune -a"
alias dc "docker compose"
alias dcb "dc build"
alias dcu "dc up"

# GlobalProtect
alias gp "globalprotect"

# Systemd
alias sc "systemctl"
alias ssc "sudo systemctl"
alias scu "systemctl --user"
alias jc "journalctl"
alias jcu "journalctl --user"

# Fix Tmux not respecting XDG_CONFIG
alias tmux "tmux -f $XDG_CONFIG_HOME/tmux/tmux.conf"

# Use GNU utilities on OSX
if test (uname) = "Darwin"
	alias ls "gls"
	alias rm "grm"
end

# Directory related shortcuts
alias .. "cd .."
alias mkdir "mkdir -pv"
alias l "ls -lah --color=auto"

# Safety Checks (aka, always prompt for confirmation)
alias mv "mv -i -v"
alias cp "cp -i -v"
alias ln "ln -i -v"
alias rm "rm -I -v"

# Make mount output prettier
alias mountt "mount | column -t"

# Force Mutt to use the correct config file
alias mutt "mutt -F ~/.config/mutt/muttrc"

# Force ncmpcpp to use sane bindings
alias ncmpcpp "ncmpcpp -b .config/ncmpcpp/bindings"

# Make viewing tasks with Taskwarrior easier
alias work "task project:work"
alias school "task project:school"
alias personal "task project:personal"
