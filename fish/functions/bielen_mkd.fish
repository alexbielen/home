function mkd -d "an mkdir alias that makes (-p)arent directories and is (-v)erbose"
  if not type -q gmkdir
    mkdir -p -v $argv
  else
    gmkdir --parents --verbose $argv
  end
end
