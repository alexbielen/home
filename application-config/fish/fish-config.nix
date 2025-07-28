{ pkgs, ... }:
{
  programs.fish = {
    enable = true;

    interactiveShellInit = ''
      set fish_greeting # Disable greeting

      # set tide prompt icon
      set -Ux tide_character_icon 'λ'

      # set XDG_CONFIG_HOME
      set -x XDG_CONFIG_HOME $HOME/.config

      # enable fish in nix shells
      any-nix-shell fish --info-right | source

      # add homebrew to path
      set -x PATH /opt/homebrew/bin $PATH

      # alias work to cd into the repos directory
      alias work="cd $HOME/repos"
    '';
    plugins = [
      {
        name = "tide";
        src = pkgs.fetchFromGitHub {
          owner = "IlanCosman";
          repo = "tide";
          rev = "a34b0c2809f665e854d6813dd4b052c1b32a32b4";
          sha256 = "sha256-ZyEk/WoxdX5Fr2kXRERQS1U1QHH3oVSyBQvlwYnEYyc=";
        };
      }
    ];
    functions = {
      gitignore = "curl -sL https://www.gitignore.io/api/$argv";
      l = {
        body = ''
          if not type -q eza
            ls -laQ $argv
          else
            eza -all --oneline --long --icons=always --show-symlinks --sort=type --git --header $argv
          end
        '';
        description = "a better, shorter, more colorful ls";
      };
      # astrology function
      astro = {
        body = ''
          	curl -s "https://horoscope-app-api.vercel.app/api/v1/get-horoscope/daily?day=TODAY&sign="$argv  | jq ".data.horoscope_data" | cowsay
          	'';
        description = "Enter your star sign for a daily horoscope.";
      };
      # config function that cds to the configuration directory
      config = {
        description = "Quickly go to nix configuration.";
        body = ''
          	  if test (count $argv) = 0
          	    # go to XDG_CONFIG_HOME
          	    cd $XDG_CONFIG_HOME/nix-darwin-config
          	  else if test $argv = "apps"
          	    cd $XDG_CONFIG_HOME/nix-darwin-config/application-config
          	  else if test $argv = "fish"
          	    cd $XDG_CONFIG_HOME/nix-darwin-config/application-config/fish
          	  else if test $argv = "git"
          	    cd $XDG_CONFIG_HOME/nix-darwin-config/application-config/git
              else if test $argv = "vscode"
                cd $XDG_CONFIG_HOME/nix-darwin-config/application-config/vscode
          	  else
          	    echo "config: expects either 0 or 1 arguments."
          	    set $status 1
          	  end
          	'';
      };
      # rb -- this is a shorthand for calling darwin-rebuild switch etc.
      rb = {
        description = "alias for for rebuilding the nix darwin configuration.";
        body = ''
          	sudo darwin-rebuild switch --flake ~/.config/nix-darwin-config
          	'';
      };
      # gitignore function -- append the output of the api call to the .gitignore file
      gi = {
        description = "generate a gitignore for the current directory and add it to the current directory.";
        body = ''
          curl -sL https://toptal.com/developers/gitignore/api/$argv >> .gitignore
          set $status 0
        '';
      };

      fish_user_key_bindings = {
        description = "fish user key bindings -- binds tab to forward-right and ctrl-f to completion";
        body = ''
          bind tab forward-char
          bind \cf complete
        '';
      };
    };
  };
}
