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
    # XDG Base Directory dotfiles
    ".config/alacritty/alacritty.toml".source = ./application-config/dotfiles/alacritty.toml;
    ".config/bat/config".source = ./application-config/dotfiles/bat-config;
    ".config/dircolors/.dircolors".source = ./application-config/dotfiles/dircolors-config;
    ".config/git/commit-template".source = ./application-config/git/commit-template;
    ".config/karabiner/karabiner.json".source = ./application-config/dotfiles/karabiner.json;
    ".config/neofetch/config.conf".source = ./application-config/dotfiles/neofetch-config.conf;

    # user-level dotfiles
    ".vimrc".source = ./application-config/dotfiles/vim-config;
  };
}
