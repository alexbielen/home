# homebrew configuration (generally try to install with nix instead)
{
  enable = true;
  # onActivation.cleanup = "uninstall";
  taps = [ "deskflow/homebrew-tap" ];
  brews = [
    {
      name = "mariadb";
      start_service = true;
    }

  ];
  casks = [
    # development
    "docker"

    # browsers
    "google-chrome"
    "firefox"

    # display management
    "betterdisplay"

    # communication
    "slack"
    "zoom"
    "signal"
    "microsoft-teams"

    # utility
    "1password"
    "raycast"
    "karabiner-elements"

    # entertainment
    "spotify"
    "vlc"
  ];
}
