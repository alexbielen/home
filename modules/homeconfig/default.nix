{ pkgs, ... }:
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
    ".config/alacritty/alacritty.toml".source = ./application-config/alacritty.toml;
    ".config/bat/config".source = ./application-config/bat-config;
    ".config/dircolors/.dircolors".source = ./application-config/dircolors-config;
    ".config/git/commit-template".source = ./application-config/git/commit-template;
    ".config/karabiner/karabiner.json".source = ./application-config/karabiner.json;
    ".config/neofetch/config.conf".source = ./application-config/neofetch-config.conf;

    ".vimrc".source = ./application-config/vim-config;
  };
}
