# source the nix environment variables and prepend nix bin directory to the $PATH
bass source $HOME/.nix-profile/etc/profile.d/nix.sh

# add doom binaries to the PATH
set PATH $PATH $HOME/.emacs.d/bin

# set XDG_CONFIG_HOME
set -x XDG_CONFIG_HOME $HOME/.config

# set vi key bindings 
fish_vi_key_bindings
