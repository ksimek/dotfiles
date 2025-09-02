# If not running interactively, don't do anything
[ -z "$PS1" ] && return

echo "sourcing bash_profile"
if [ -f $HOME/.bash_profile ]; then
   source $HOME/.bash_profile
fi
