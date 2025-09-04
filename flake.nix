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
      configuration = import ./modules/configuration;
      homeconfig = import ./modules/homeconfig;
      darwinSystem = nix-darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        modules = [
          configuration
          {
            # this is a hack to pass inputs to the configuration module there has to be a better way
            _module.args = {
              inherit inputs;
            };
          }
          mac-app-util.darwinModules.default
          home-manager.darwinModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.verbose = true;
            home-manager.users.${user} = homeconfig;
            home-manager.sharedModules = [
              mac-app-util.homeManagerModules.default
            ];
          }
        ];
      };
    in
    {
      # Build darwin flake using:
      # $ darwin-rebuild switch --flake .
      darwinConfigurations = {
        # Mac Mini
        uncool = darwinSystem;

        # M4 Macbook Pro
        campfire = darwinSystem;
      };
    };
}
