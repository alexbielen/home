# py wraps ptpython and passes the correct values.
# 
# 
function py
  if type -q ptpython
    command ptpython --config-file $XDG_CONFIG_HOME/ptpython/config.py $argv
  else
    echo "ptpython not installed. This usually means you're not in a Nix shell."
  end
end
