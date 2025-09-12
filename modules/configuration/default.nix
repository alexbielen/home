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
  # I'm currently running this as a single user system so this is empty.
  environment.systemPackages = [ ];

  # nixpkgs configuration
  nixpkgs.config.allowUnfree = true;
  nixpkgs.overlays = [
    inputs.nix-vscode-extensions.overlays.default
  ];
  nixpkgs.hostPlatform = "aarch64-darwin";

  # homebrew configuration (generally try to install with nix instead)
  homebrew = import ./homebrew.nix;

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

    # This runs after activation (darwin-rebuild switch) and applies settings immediately.
    # Otherwise we would need to logout/login or restart the system to apply the settings.
    # h/t https://medium.com/@zmre/nix-darwin-quick-tip-activate-your-preferences-f69942a93236
    system.activationScripts.postUserActivation.text = ''
      /System/Library/PrivateFrameworks/SystemAdministration.framework/Resources/activateSettings -u
    '';
    primaryUser = user;
    defaults = {
      LaunchServices = {
        LSQuarantine = false;
      };
      NSGlobalDomain = {

        # Show all extensions in Finder
        AppleShowAllExtensions = true;
        # Disable press and hold to enable key repeat
        ApplePressAndHoldEnabled = false;
        # Automatically switch to dark mode based on time of day
        AppleInterfaceStyleSwitchesAutomatically = true;
        # This disables the default behavior of switching to the
        # workspace with the active window of application.
        AppleSpacesSwitchOnActivate = false;
        # Show the expanded save panel
        NSNavPanelExpandedStateForSaveMode = true;
        # Draggable windows
        NSWindowShouldDragOnGesture = true;

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
        mru-spaces = false;
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
