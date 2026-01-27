# Setting up SSH to sign commits and SSH

## Signing commits with YubiKey

Just watch this video https://www.youtube.com/watch?v=7LuMTyhFA-g

## GitHub SSH

I set up a particular match block in SSH config in home manager.

I ran `ssh-keygen -t ed25519-sk -C "alexhendriebielen@gmail.com"` to get a "resident" key.

I tried other options first, such as `-O resident` but it's unclear why that was not working.

Check that `ssh-agent` is started: `eval (ssh agent -c)`

Add key: `ssh-add ~/.ssh/ed25519-sk`

Grab the public key and add to GitHub: `pbcopy > ~/.ssh/ed25519-sk.pub`

Test that you can connect to GitHub over SSH: `ssh -T git@github.com`
