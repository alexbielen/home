
function l -d "a better, shorter, more colorful ls"
  if not type -q gls
    ls -laQ $argv
  else
    gls -la --group-directories-first --human-readable --time-style=long-iso --color=auto $argv
  end
end
