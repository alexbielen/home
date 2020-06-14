# This defines the set of development tools that I 
# use globally, outside of a specific language use case. 
with { pkgs = import <nixpkgs> {}; };

let 
    bielenShell = with pkgs;
      [
          pkgs.alacritty
          pkgs.bat
          pkgs.curl
          pkgs.coreutils-prefixed
          pkgs.emacs
          pkgs.fd
          pkgs.fish
          pkgs.fzf
          pkgs.git
	  pkgs.git-secrets
          pkgs.gnupg
          pkgs.htop
          pkgs.icdiff
          pkgs.jq
          pkgs.less
          pkgs.lorri
	  pkgs.neofetch
          pkgs.neovim
          pkgs.ripgrep
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
