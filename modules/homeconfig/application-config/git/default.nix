{
  config,
  lib,
  pkgs,
  ...
}:
{
  programs.git = {
    enable = true;
    userName = "Alex Bielen";
    userEmail = "alexhendriebielen@gmail.com";
    ignores = [ ".DS_Store" ];
    extraConfig = {
      core = {
        pager = "bat";
        editor = "nvim";
      };
      commit = {
        template = "~/.config/git/commit-template";
      };
      init = {
        defaultBranch = "main";
      };
      push = {
        autoSetupRemote = true;
      };
    };
  };
}
