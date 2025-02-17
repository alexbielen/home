{ pkgs, ... }:
{
  programs.vscode = {
    enable = true;

    userSettings = {
      # this attrset generates the settings.json file in VSCODE
      editor.formatOnSave = true;
      workbench.colorTheme = "Nord";
    };

    keybindings = [
      {
        key = "shift+cmd+j";
        command = "workbench.action.focusActiveEditorGroup";
        when = "terminalFocus";
      }
    ];

    extensions = with pkgs.vscode-marketplace; [
      # ms-vscode.cpptools (this was removed?)
      arcticicestudio.nord-visual-studio-code
      bmalehorn.vscode-fish
      dbaeumer.vscode-eslint
      github.copilot
      github.vscode-github-actions
      jnoortheen.nix-ide
      ms-python.black-formatter
      ms-python.debugpy
      ms-python.flake8
      ms-python.python
      ms-vscode.cmake-tools
      ms-vscode.cpptools-extension-pack
      rust-lang.rust-analyzer
      vscodevim.vim
    ];
  };
}
