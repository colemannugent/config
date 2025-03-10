# apt-get and aptitude
abbr -a uu "sudo apt update && sudo apt upgrade -y && sudo apt autoremove"
abbr -a ai "sudo apt install"
abbr -a alu "sudo apt list --upgradeable"
abbr -a ar "sudo apt remove"
abbr -a aar "sudo apt-get autoremove"
abbr -a acs "sudo apt-cache search"

# Editor shortcuts
alias v="$EDITOR -p"
abbr -a vf "v (fzf)"
abbr -a sv "sudoedit"
abbr -a note "v \"(date +\"%A, %B %e %Y\")\".md"

# VSCode
abbr -a c "code"

# Ranger
abbr -a r "ranger"

# Git
abbr -a gl "git log --color --graph --pretty=format:\"%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr)%C(bold blue) <%an %GK> %Creset\" --abbrev-commit"
abbr -a ga "git add"
abbr -a gc "git commit --verbose"
abbr -a gd "git diff"
abbr -a gs "git status"
abbr -a grc "git rebase --continue"
abbr -a gte "git log --oneline --since=12hours --pretty=format:\"- %s\""

# Docker
abbr -a d "docker"
abbr -a db "docker build"
abbr -a de "docker exec -it"
abbr -a dp "docker pull"
abbr -a dspa "docker system prune -a"
abbr -a dc "docker compose"
abbr -a dcb "docker compose build"
abbr -a dcu "docker compose up"

# GlobalProtect
abbr -a gp "globalprotect"

# Systemd
abbr -a sc "systemctl"
abbr -a ssc "sudo systemctl"
abbr -a scu "systemctl --user"
abbr -a jc "journalctl"
abbr -a jcu "journalctl --user"

# Fix Tmux not respecting XDG_CONFIG
alias tmux "tmux -f $XDG_CONFIG_HOME/tmux/tmux.conf"

# Use GNU utilities on OSX
if test (uname) = "Darwin"
	abbr -a ls "gls"
	abbr -a rm "grm"
end

# Directory related shortcuts
abbr -a .. "cd .."
abbr -a mkdir "mkdir -pv"
alias l="ls -lah --color=auto"

# Safety Checks (aka, always prompt for confirmation)
abbr -a mv "mv -i -v"
abbr -a cp "cp -i -v"
abbr -a ln "ln -i -v"
abbr -a rm "rm -I -v"

# Make mount output prettier
abbr -a mountt "mount | column -t"

# Force Mutt to use the correct config file
abbr -a mutt "mutt -F ~/.config/mutt/muttrc"

# Force ncmpcpp to use sane bindings
abbr -a ncmpcpp "ncmpcpp -b .config/ncmpcpp/bindings"

# Make viewing tasks with Taskwarrior easier
abbr -a work "task project:work"
abbr -a school "task project:school"
abbr -a personal "task project:personal"
