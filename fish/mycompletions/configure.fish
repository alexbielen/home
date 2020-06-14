# set up completions for configure script
# This terrible incantation reads the directories in XDG_CONFIG_HOME and does some text munging
set dirstring (ls -F $XDG_CONFIG_HOME | grep / | string collect | string replace \n " " | string replace / "" | string replace doc "")
complete -c configure -f -a "$dirstring"