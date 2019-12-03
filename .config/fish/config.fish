# Non-interactive users (sshy, sync)
if not status --is-interactive
	exit # Skips the rest of this file, not exiting the shell
end

# Set default editor to vim
export EDITOR=/usr/bin/vim
export VISUAL=$EDITOR

# Set some real ls colors
# export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=34;46:cd=34;43:su=30;41:sg=30;46:tw=30;42:ow=30;43'

# Add colors to ls and friends
if test -e /usr/bin/dircolors -a -e ~/.config/dircolors
	eval (dircolors -c ~/.config/dircolors)
	alias ls 'ls --color=auto'
	alias grep 'grep --color=auto'
	alias fgrep 'fgrep --color=auto'
	alias egrep 'egrep --color=auto'
end

# Make vim know where everything is
export VIMINIT='let $MYVIMRC="$XDG_CONFIG_HOME/vim/vimrc" | source $MYVIMRC'

# Set XDG variables
export XDG_CONFIG_HOME=$HOME'/.config/'
export XDG_CACHE_HOME=$HOME'/.cache/'
export XDG_DATA_HOME=$HOME'/.local/share'

# Tell GPG where it is
export GNUPGHOME="$XDG_CONFIG_HOME"gnupg

# apt-get and aptitude
alias upandup "sudo apt update && sudo apt upgrade -y"
alias install "sudo apt install"
alias remove "sudo apt remove"
alias autoremove "sudo apt-get autoremove"
alias search "sudo apt-cache search"

# ViM
alias v "vim -p"
alias vf "v (fzf)"
alias sv "svim"
alias svim "sudoedit"
alias note "vim \"(date +\"%A, %B %e %Y\")\".md"

# Git
alias gl "git log --color --graph --pretty=format:\"%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr)%C(bold blue) <%an %GK> %Creset\" --abbrev-commit"
alias ga "git add"
alias gc "git commit --verbose"
alias gd "git diff"
alias gs "git status"
alias gte "git log --oneline --since=12hours --pretty=format:\"- %s\""

# Docker
alias d "docker"
alias db "docker build"
alias de "docker exec -it"
alias dp "docker pull"
alias dspa "docker system prune -a"
alias dc "docker-compose"
alias dcb "dc build"
alias dcu "dc up"

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
