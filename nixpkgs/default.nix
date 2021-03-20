# This defines the set of development tools that I 
# use globally, outside of a specific language use case. 
with { pkgs = import <nixpkgs> {}; };

let 
    bielenShell = with pkgs;
      [
        pkgs.alacritty
        pkgs.bat
	pkgs.cabal-install
        pkgs.cacert
        pkgs.curl
        pkgs.coreutils-prefixed
        pkgs.direnv
        pkgs.fd
        pkgs.fish
        pkgs.fzf
        pkgs.git
        pkgs.git-secrets
        pkgs.gnupg
        pkgs.htop
        pkgs.hugo
        pkgs.icdiff
        pkgs.jq
        pkgs.less
        pkgs.lorri
        pkgs.neofetch
        pkgs.neovim
        pkgs.nix
        pkgs.nodejs-14_x
	pkgs.python38
	pkgs.poetry
        pkgs.ripgrep
        pkgs.rustup
	pkgs.shellcheck
	pkgs.tmux
        pkgs.tree
        pkgs.vscode
        pkgs.which
        pkgs.xclip
        pkgs.xz
      ];

in 
  if pkgs.lib.inNixShell
  then pkgs.mkShell 
    { 
        buildInputs = bielenShell;
    }
   else bielenShell
