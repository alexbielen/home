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
      configuration =
        { pkgs, ... }:
        {
          # List packages installed in system profile. To search by name, run:
          # $ nix-env -qaP | grep wget
          environment.systemPackages = [ ];

          # nixpkgs configuration
          nixpkgs.config.allowUnfree = true;
          nixpkgs.overlays = [
            nix-vscode-extensions.overlays.default
          ];
          nixpkgs.hostPlatform = "aarch64-darwin";

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
            casks = [
              "raycast"
              "spotify"
              "karabiner-elements"
            ];
          };

          # Necessary for using flakes on this system.
          nix.settings.experimental-features = "nix-command flakes";
          nix.enable = false;

          # Enable alternative shell support in nix-darwin.
          programs.fish.enable = true;

          # Set Git commit hash for darwin-version.
          system.configurationRevision = self.rev or self.dirtyRev or null;

          # Used for backwards compatibility, please read the changelog before changing.
          # $ darwin-rebuild changelog
          system.stateVersion = 6;

          # fonts
          fonts.packages = [
            pkgs.nerd-fonts.hack
          ];

          users.users.${user} = {
            home = "/Users/${user}";
          };

          system.primaryUser = user;
        };

      darwinSystem = nix-darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        modules = [
          configuration
          mac-app-util.darwinModules.default
          home-manager.darwinModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.verbose = true;
            home-manager.users.${user} = {
              imports = [
                ./modules/homeconfig
              ];
            };
            home-manager.sharedModules = [
              mac-app-util.homeManagerModules.default
            ];
          }
        ];
      };
    in
    {
      # Build darwin flake using:
      # $ darwin-rebuild build --flake
      darwinConfigurations = {
        # Mac Mini
        uncool = darwinSystem;

        # M4 Macbook Pro
        campfire = darwinSystem;
      };
    };
}
