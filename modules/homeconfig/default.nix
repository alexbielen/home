{
  config,
  lib,
  pkgs,
  ...
}:
{
  # this is internal compatibility configuration
  # for home-manager, don't change this!
  home.stateVersion = "23.05";
  # Let home-manager install and manage itself.
  programs.home-manager.enable = true;

  imports = [
    ./application-config/fish # fish configuration
    ./application-config/vscode # vscode configuration
    ./application-config/git # git configuration
    ./application-config/ssh # ssh configuration
  ];

  # universally available packages
  home.packages = with pkgs; [
    # encryption and security
    age
    age-plugin-yubikey
    gnupg
    openssh
    yubikey-manager
    libfido2

    # terminal emulator and shell
    alacritty
    any-nix-shell
    fish
    starship
    direnv

    # GUI tools
    element-desktop

    # viewer and file manager
    bat
    eza
    tree

    # version control
    gh
    git
    git-credential-manager
    icdiff

    # performance and system monitoring
    btop

    # code editing
    neovim
    vim
    code-cursor
    nixfmt-rfc-style

    # text processing
    ripgrep
    jq

    # utilities
    coreutils-prefixed
    neofetch
    blueutil
    ffmpeg

    # networking
    nmap
    wireguard-tools
    wget
    dig
    zip

    # entertainment
    cowsay
    ponysay
    sl
    fortune
  ];

  home.sessionVariables = {
    EDITOR = "vim";
  };

  home.file = {
    # XDG Base Directory dotfiles
    ".config/alacritty/alacritty.toml".source = ./application-config/dotfiles/alacritty.toml;
    ".config/bat/config".source = ./application-config/dotfiles/bat-config;
    ".config/dircolors/.dircolors".source = ./application-config/dotfiles/dircolors-config;
    ".config/git/commit-template".source = ./application-config/git/commit-template;
    ".config/karabiner/karabiner.json".source = ./application-config/dotfiles/karabiner.json;
    ".config/neofetch/config.conf".source = ./application-config/dotfiles/neofetch-config.conf;
    ".config/starship.toml".source = ./application-config/dotfiles/starship.toml;

    # user-level dotfiles
    ".vimrc".source = ./application-config/dotfiles/vim-config;
  };
}
