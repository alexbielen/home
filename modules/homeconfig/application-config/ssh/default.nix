{
  config,
  lib,
  pkgs,
  ...
}:
{
  programs.ssh = {
    enable = true;

    matchBlocks = {
      "github" = {
        user = "git";
        hostname = "github.com";
        addKeysToAgent = "yes";
        identityFile = "~/.ssh/id_ed25519_sk";
      };
    };
  };
}
