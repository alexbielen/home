# source the nix environment variables and prepend nix bin directory to the $PATH
bass source $HOME/.nix-profile/etc/profile.d/nix.sh

# set XDG_CONFIG_HOME
set -x XDG_CONFIG_HOME $HOME/.config

# add myfunctions to function path
set fish_function_path $HOME/.config/fish/myfunctions $fish_function_path

# set vi key bindings 
fish_vi_key_bindings
