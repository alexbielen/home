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
      arcticicestudio.nord-visual-studio-code
      bmalehorn.vscode-fish
      dbaeumer.vscode-eslint
      github.copilot
      github.vscode-github-actions
      ms-python.black-formatter
      ms-python.debugpy
      ms-python.flake8
      ms-python.python
      # ms-vscode.cpptools (this was removed?)
      ms-vscode.cmake-tools
      ms-vscode.cpptools-extension-pack
      rust-lang.rust-analyzer
    ];
  };
}
