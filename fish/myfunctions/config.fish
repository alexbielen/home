# config quickly takes you to the configuration directory for tools in home.
function config -d "quickly go to configuration directory for a tool in home" 
  if test (count $argv) = 0
    # go to XDG_CONFIG_HOME
    cd $XDG_CONFIG_HOME
  else if test (count $argv) = 1
    # test if directory exists
    set dir $XDG_CONFIG_HOME/$argv[1]
    if test -e $dir
      cd $dir
    else
      echo "config: configuration directory $dir does not exist."
      set $status 1
    end
  else
    echo "config: expects either 0 or 1 arguments."
    set $status 1
  end
end
    