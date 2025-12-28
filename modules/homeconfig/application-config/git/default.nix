{
  config,
  lib,
  pkgs,
  ...
}:
{
  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "Alex Bielen";
        email = "alexhendriebielen@gmail.com";
      };
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
    ignores = [ ".DS_Store" ];
  };
}
