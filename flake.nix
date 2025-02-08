{
  description = "Example nix-darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs?rev=d2faa1bbca1b1e4962ce7373c5b0879e5b12cef2";
    nix-darwin = {
	url = "github:LnL7/nix-darwin/master";
        inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
	url = "github:nix-community/home-manager";
	inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs, home-manager }:
  let
    configuration = { pkgs, ... }: {
      # List packages installed in system profile. To search by name, run:
      # $ nix-env -qaP | grep wget
      environment.systemPackages = [ ];

      # Necessary for using flakes on this system.
      nix.settings.experimental-features = "nix-command flakes";

      # Enable alternative shell support in nix-darwin.
      programs.fish.enable = true;

      # Set Git commit hash for darwin-version.
      system.configurationRevision = self.rev or self.dirtyRev or null;

      # Used for backwards compatibility, please read the changelog before changing.
      # $ darwin-rebuild changelog
      system.stateVersion = 6;

      # The platform the configuration will be used on.
      nixpkgs.hostPlatform = "aarch64-darwin";

      # fonts
      fonts.packages = [
	pkgs.nerd-fonts.hack
      ];

      users.users."alexbielen" = {
	home = "/Users/alexbielen";
	description = "alexbielen";
	shell = pkgs.fish;
	};
    };
	homeconfig = {pkgs, ...}: {
	    # this is internal compatibility configuration 
	    # for home-manager, don't change this!
	    home.stateVersion = "23.05";
	    # Let home-manager install and manage itself.
	    programs.home-manager.enable = true;
	    programs.fish.enable = true;

	    home.packages = with pkgs; [
		pkgs.vim
		pkgs.neofetch
		pkgs.alacritty
		pkgs.gh
		pkgs.bat
		pkgs.neovim
		pkgs.icdiff
		pkgs.fish
	    ];

	    home.sessionVariables = {
		EDITOR = "vim";
	    };

	    home.file = {
	    	".vimrc".source = ./application-config/vim-config;
		".config/alacritty/alacritty.toml".source = ./application-config/alacritty.toml;
	    };

	    programs.git = {
		enable = true;
		userName = "Alex Bielen";
		userEmail = "alexhendriebielen@gmail.com";
		ignores = [ ".DS_Store" ];
		extraConfig = {
		  init.defaultBranch = "main";
		  push.autoSetupRemote = true; 
		};
	    };
	};
  in
  {
    # Build darwin flake using:
    # $ darwin-rebuild build --flake .#Alexs-Mac-mini
    darwinConfigurations."Alexs-Mac-mini" = nix-darwin.lib.darwinSystem {
      modules = [ 
	configuration
	home-manager.darwinModules.home-manager {
	  home-manager.useGlobalPkgs = true;
	  home-manager.useUserPackages = true;
	  home-manager.verbose = true;
	  home-manager.users.alexbielen = homeconfig;
	  }
	 ];
    };
  };
}
