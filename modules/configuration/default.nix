{
  config,
  lib,
  pkgs,
  ...
}:
let
  user = "alexbielen";
  inputs = config._module.args.inputs or { };
in
{
  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = [ ];

  # nixpkgs configuration
  nixpkgs.config.allowUnfree = true;
  nixpkgs.overlays = [
    inputs.nix-vscode-extensions.overlays.default
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
  system.configurationRevision = inputs.self.rev or inputs.self.dirtyRev or null;

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
}
