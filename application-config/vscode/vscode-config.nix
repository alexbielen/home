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

        # disable auto-closing brackets, etc.
        "editor.autoClosingBrackets" = "never";
        "editor.autoClosingDelete" = "never";
        "editor.autoClosingQuotes" = "never";
      };

      keybindings = [
        {
          key = "ctrl+e";
          command = "workbench.action.focusActiveEditorGroup";
          when = "terminalFocus";
        }
        # toggle terminal
        {
          key = "ctrl+t";
          command = "workbench.action.terminal.toggleTerminal";
          when = "editorTextFocus";
        }
        # cycle through open editors
        {
          key = "ctrl+l";
          command = "workbench.action.nextEditor";
          when = "editorTextFocus";
        }
        {
          key = "ctrl+h";
          command = "workbench.action.previousEditor";
          when = "editorTextFocus";
        }

        # add keybindings for navigating the completion list
        {
          key = "ctrl+k";
          command = "selectNextSuggestion";
          when = "suggestWidgetMultipleSuggestions && suggestWidgetVisible && textInputFocus || suggestWidgetVisible && textInputFocus && !suggestWidgetHasFocusedSuggestion";
        }
        {
          key = "ctrl+j";
          command = "selectPrevSuggestion";
          when = "suggestWidgetMultipleSuggestions && suggestWidgetVisible && textInputFocus || suggestWidgetVisible && textInputFocus && suggestWidgetHasFocusedSuggestion";
        }
      ];

      # TODO: add extensions to the default profile
      extensions = with pkgs.vscode-marketplace; [
        # ms-vscode.cpptools (this was removed?)
        arcticicestudio.nord-visual-studio-code
        bmalehorn.vscode-fish
        dbaeumer.vscode-eslint
        esbenp.prettier-vscode
        figma.figma-vscode-extension
        github.copilot
        github.vscode-github-actions
        golang.go
        jnoortheen.nix-ide
        eamodio.gitlens
        ms-python.black-formatter
        ms-python.debugpy
        ms-python.flake8
        ms-playwright.playwright
        ms-python.python
        ms-vscode.cmake-tools
        ms-vscode.cpptools-extension-pack
        rust-lang.rust-analyzer
        tamasfe.even-better-toml
        vscodevim.vim
        vitest.explorer
        vue.volar
      ];
    };
  };
}
