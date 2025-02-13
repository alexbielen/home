{ pkgs, ... }: {
  programs.fish = {
    enable = true;

    interactiveShellInit = ''
      set fish_greeting # Disable greeting
      
      # set tide prompt icon
      set -Ux tide_character_icon 'λ'
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
          if not type -q gls
            ls -laQ $argv
          else
            gls -la --group-directories-first --human-readable --time-style=long-iso --color=auto $argv
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
    };
  };
}
