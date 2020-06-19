
# set XDG_CONFIG_HOME
set -x XDG_CONFIG_HOME $HOME/.config

# set the SHELL variable 
# TODO: I'm not sure why this isn't set at login so I'll need to look into that.
set -x SHELL $HOME/.nix-profile/bin/fish

# add myfunctions to function path
set fish_function_path $HOME/.config/fish/myfunctions $fish_function_path

# add mycompletions to completion path
set fish_complete_path $XDG_CONFIG_HOME/fish/mycompletions $fish_complete_path

# set vi key bindings 
fish_vi_key_bindings

######
# package managers
######

## fisher
# this installs the fisher package manager for fish.
# It also installs all plugins located in the fish file. 
if not functions -q fisher
    set -q XDG_CONFIG_HOME; or set XDG_CONFIG_HOME ~/.config
    curl https://git.io/fisher --create-dirs -sLo $XDG_CONFIG_HOME/fish/functions/fisher.fish
    fish -c fisher
end

## Nix
# source the nix environment variables and prepend nix bin directory to the $PATH
# note: this has to go after fisher setup because we're using bass.
bass source $HOME/.nix-profile/etc/profile.d/nix.sh

# set pure prompt to lambda symbol
set -g pure_symbol_prompt "λ"

# load theme
# using nord https://www.nordtheme.com/docs/colors-and-palettes
# Nord is divided into four sections. 
# I'm using the dark ambiance style which uses 
# Polar Night for background and area colors. 
# It's possible to use Snow Storm for light ambiance styles.

# Polar Night
set nord0 2e3440 # backgrounds 
set nord1 3b4252 # status bars, gutters, panels
set nord2 434c5e # brighter nord 2
set nord3 4c566a # comments, invisible characters

# Snow Storm
set nord4 d8dee9  # plain text
set nord5 e5e9f0  # subtle/inconspicuous UI text 
set nord6 eceff4  # elevated plain text

# Frost
set nord7 8fbcbb
set nord8 88c0d0
set nord9 81a1c1 
set nord10 5e81ac

# Aurora
set nord11 bf616a # error state
set nord12 d08770 
set nord13 ebcb8b
set nord14 a3be8c
set nord15 b48ead

# fish config
set -g fish_color_command $nord8
set -g fish_color_autosuggestion $nord3
set -g fish_color_quote $nord13
set -g fish_color_end $nord15
set -g fish_color_operator $nord10
set -g fish_color_redirection $nord9
set -g fish_color_param $nord4
set -g fish_color_error $nord11
set -g fish_color_cwd $nord9
set -g fish_color_cancel $nord13

# fish pager
set -g fish_pager_color_progress $nord13 --background=$nord2
set -g fish_pager_color_prefix $nord6 --bold --underline
set -g fish_pager_color_completion $nord4
set -g fish_pager_color_description $nord13
set -g fish_pager_color_secondary_background $nord3


# pure theme config
set -g pure_color_mute $nord3
set -g pure_color_primary $nord9
set -g pure_color_prompt_on_success $nord15

# set up dircolors
set dircolors_file $XDG_CONFIG_HOME/dircolors/.dircolors
test -r $dircolors_file && eval (gdircolors -c $dircolors_file)
