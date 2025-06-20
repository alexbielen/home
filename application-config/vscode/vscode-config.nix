{ pkgs, ... }:
{
  programs.vscode = {
    enable = true;

    # we don't want anything else writing to the extensions directory
    mutableExtensionsDir = false;

    profiles.default = {

      userSettings = {
        # this attrset generates the settings.json file in VSCODE
        editor.formatOnSave = true;
        workbench.colorTheme = "Nord";

        # make fish the default shell for macOS
        "terminal.integrated.profiles.osx" = {
          "fish" = {
            "path" = "${pkgs.fish}/bin/fish";
          };
        };
        "terminal.integrated.defaultProfile.osx" = "fish";

        # disable auto-updates and set to manual instead to avoid the annoying popup
        "update.mode" = "manual";

        # disable gitlens nagging about plusFeatures
        "gitlens.plusFeatures.enabled" = false;
      };

      keybindings = [
        {
          key = "shift+cmd+j";
          command = "workbench.action.focusActiveEditorGroup";
          when = "terminalFocus";
        }
        # toggle terminal
        {
          key = "ctrl+t";
          command = "workbench.action.terminal.toggleTerminal";
        }
      ];

      # TODO: add extensions to the default profile
      extensions = with pkgs.vscode-marketplace; [
        # ms-vscode.cpptools (this was removed?)
        arcticicestudio.nord-visual-studio-code
        bmalehorn.vscode-fish
        dbaeumer.vscode-eslint
        github.copilot
        github.vscode-github-actions
        golang.go
        jnoortheen.nix-ide
        # add gitlens
        eamodio.gitlens
        ms-python.black-formatter
        ms-python.debugpy
        ms-python.flake8
        ms-python.python
        ms-vscode.cmake-tools
        ms-vscode.cpptools-extension-pack
        rust-lang.rust-analyzer
        tamasfe.even-better-toml
        vscodevim.vim
      ];
    };
  };
}
