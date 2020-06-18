
# set XDG_CONFIG_HOME
set -x XDG_CONFIG_HOME $HOME/.config

# set the SHELL variable 
# TODO: I'm not sure why this isn't set at login so I'll need to look into that.
set -x SHELL (which fish)

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


