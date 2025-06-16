{
  description = "Alex Bielen's system configuration.";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin = {
      url = "github:LnL7/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-vscode-extensions = {
      url = "github:nix-community/nix-vscode-extensions";
    };
    mac-app-util = {
      url = "github:hraban/mac-app-util";
    };
  };

  outputs =
    inputs@{
      self,
      nix-darwin,
      nixpkgs,
      home-manager,
      nix-vscode-extensions,
      mac-app-util,
    }:
    let
      user = "alexbielen";
      host = "Alexs-Mac-mini";
      configuration =
        { pkgs, ... }:
        {
          # List packages installed in system profile. To search by name, run:
          # $ nix-env -qaP | grep wget
          environment.systemPackages = [ ];

          # homebrew configuration (generally try to install with nix instead)
          homebrew = {
            enable = true;
            # onActivation.cleanup = "uninstall";
            taps = [ ];
            brews = [
              {
                name = "mariadb";
                start_service = true;
              }
            ];
            casks = [ ];
          };

          # allow unfree packages e.g., vscode
          nixpkgs.config.allowUnfree = true;

          # overlays
          nixpkgs.overlays = [
            nix-vscode-extensions.overlays.default
          ];

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

          users.users.${user} = {
            home = "/Users/${user}";
          };

          system.primaryUser = user;
        };
      homeconfig =
        { pkgs, ... }:
        {
          # this is internal compatibility configuration
          # for home-manager, don't change this!
          home.stateVersion = "23.05";
          # Let home-manager install and manage itself.
          programs.home-manager.enable = true;

          imports = [
            ./application-config/fish/fish-config.nix # fish configuration
            ./application-config/vscode/vscode-config.nix # vscode configuration
          ];

          # universally available packages
          home.packages = with pkgs; [
            pkgs.alacritty
            pkgs.any-nix-shell
            pkgs.bat
            pkgs.code-cursor
            pkgs.coreutils-prefixed
            pkgs.cowsay
            pkgs.element-desktop
            pkgs.eza
            pkgs.fish
            pkgs.gh
            pkgs.icdiff
            pkgs.neofetch
            pkgs.neovim
            pkgs.nixfmt-rfc-style
            pkgs.ripgrep
            pkgs.tree
            pkgs.ponysay
            pkgs.vim
          ];

          home.sessionVariables = {
            EDITOR = "vim";
          };

          home.file = {
            ".config/alacritty/alacritty.toml".source = ./application-config/alacritty.toml;
            ".config/bat/config".source = ./application-config/bat-config;
            ".config/dircolors/.dircolors".source = ./application-config/dircolors-config;
            ".config/git/commit-template".source = ./application-config/git/commit-template;
            ".config/neofetch/config.conf".source = ./application-config/neofetch-config.conf;
            ".vimrc".source = ./application-config/vim-config;
          };

          # Not sure if this will be a problem but if so read this https://ayats.org/blog/dont-use-import
          programs.git = import ./application-config/git/git-config.nix;
        };
    in
    {
      # Build darwin flake using:
      # $ darwin-rebuild build --flake
      darwinConfigurations.${host} = nix-darwin.lib.darwinSystem {
        modules = [
          configuration
          mac-app-util.darwinModules.default
          home-manager.darwinModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.verbose = true;
            home-manager.users.alexbielen = homeconfig;
            home-manager.sharedModules = [
              mac-app-util.homeManagerModules.default
            ];
          }
        ];
      };
    };
}
