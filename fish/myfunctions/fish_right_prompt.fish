
function fish_right_prompt -d "A right prompt. Used to show when in a nix-shell."
    if set -q IN_NIX_SHELL
        set_color $nord3; echo "[Nix]"
    end
end