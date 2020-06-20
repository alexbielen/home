function man --wraps man --description 'Display colorful manual pages'

    set -l end (printf "\e[0m")

    set -lx LESS_TERMCAP_mb (set_color --bold=$nord15)
    
    # bold and end bold
    set -lx LESS_TERMCAP_md (set_color $nord9)
    set -lx LESS_TERMCAP_me $end

    # standout and end standout
    set -lx LESS_TERMCAP_so (set_color $nord7 --background=$nord1)
    set -lx LESS_TERMCAP_se $end

    # underline and end underline
    set -lx LESS_TERMCAP_us (set_color -u $nord13)
    set -lx LESS_TERMCAP_ue $end
    set -lx LESS '-R -s'

    command man $argv
end