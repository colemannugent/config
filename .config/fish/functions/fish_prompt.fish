# Defined in /tmp/fish.2JiOyN/fish_prompt.fish @ line 2
function fish_prompt --description 'Write out the prompt'
	#set -l tmp $status
    	#if test $tmp -ne 0
    	#    echo "Command returned $tmp"
    	#    set 0 $status
    	#end

    set -l user_color
    set -l hostname_color
    set -l suffix
    set -l suffix_flags
    switch "$USER"
        case root toor
	    set user_color 'red'
            set suffix '#'
        case '*'
	    set user_color 'normal'
            set suffix '$'
    end

    if string match -rq 'prd.*' -- $hostname
    	set hostname_color 'red'

    else if string match -rq '.*macbook' -- $hostname
    	set hostname_color 'yellow'

    else if string match -q 'neon' -- $hostname
    	set hostname_color 'blue'

    else
	set hostname_color 'white'
    end

    if set -q VIM
        set suffix_flags "v" $suffix_flags
    end

    if test -d '.git'
        set suffix_flags "g" $suffix_flags
    end

    if string match -qv '' $suffix_flags
        set suffix "[$suffix_flags]" $suffix
    end

    echo -n -s (set_color "cyan") "$USER" (set_color normal) @ (set_color $hostname_color) (prompt_hostname) (set_color normal) ' ' (set_color 'purple') (prompt_pwd) (set_color normal) " $suffix "
end
