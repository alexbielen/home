# homebrew configuration (generally try to install with nix instead)
{
  enable = true;
  onActivation.cleanup = "uninstall";
  taps = [ "deskflow/homebrew-tap" ];
  brews = [
    {
      name = "mariadb";
      start_service = true;
    }

  ];
  casks = [
    # development
    "docker-desktop"

    # browsers
    "google-chrome"
    "firefox"

    # display management
    "betterdisplay"

    # communication
    "slack"
    "zoom"
    "signal"

    # utility
    "1password"
    "deskflow"
    "karabiner-elements"
    "raycast"

    # entertainment
    "spotify"
    "vlc"
  ];
}
