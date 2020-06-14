# git init is configured to use a template dir. In addition to copying those 
# files into .git, what it does is creates a HEAD file which is a reference to master.
# I'm trying to remove uninclusive terminology from my workflows, so I am using trunk 
# as the default branch name. If you include the HEAD file in the template directory, 
# git will say that you're reinitializing a repository. Instead, this calls the vanilla git init
# which pulls in my template, and then changes the HEAD files to reference trunk. 
function git --wraps git
  if contains init $argv
    command git $argv
    echo "ref: refs/heads/trunk" > .git/HEAD
  else
    command git $argv
  end
end
