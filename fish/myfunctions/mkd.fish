function mkd -d "an mkdir alias that makes (-p)arent directories and changes into the new directory."
  if not type -q gmkdir
    mkdir -p -v $argv
    cd $argv
  else
    gmkdir --parents --verbose $argv
    cd $argv
  end
end
