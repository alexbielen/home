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

  # fonts
  fonts.packages = [
    pkgs.nerd-fonts.hack
  ];

  system = {
    configurationRevision = inputs.self.rev or inputs.self.dirtyRev or null;
    # Used for backwards compatibility, please read the changelog before changing.
    # $ darwin-rebuild changelog
    stateVersion = 6;
    primaryUser = user;
    defaults = {
      LaunchServices = {
        LSQuarantine = false;
      };
      NSGlobalDomain = {
        AppleShowAllExtensions = true;
        ApplePressAndHoldEnabled = false;

        # 120, 90, 60, 30, 12, 6, 2
        KeyRepeat = 2;

        # 120, 94, 68, 35, 25, 15
        InitialKeyRepeat = 15;
        "com.apple.mouse.tapBehavior" = 1;
        "com.apple.sound.beep.volume" = 0.0;
        "com.apple.sound.beep.feedback" = 0;
      };
      dock = {
        autohide = false;
        show-recents = false;
        launchanim = true;
        mouse-over-hilite-stack = true;
        orientation = "bottom";
        tilesize = 48;
      };
      finder = {
        _FXShowPosixPathInTitle = false;
      };
      trackpad = {
        Clicking = true;
        TrackpadThreeFingerDrag = true;
      };
    };
  };

  security.pam.services.sudo_local.touchIdAuth = true;

  # users
  users.users.${user} = {
    home = "/Users/${user}";
  };

}
