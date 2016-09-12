# If not running interactively, don't do anything
[ -z "$PS1" ] && return

if [ -f $HOME/.bash_profile ]; then
   source $HOME/.bash_profile
fi


if [ -f $HOME/.rvm/bin ]; then
    PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
fi


. /home/kyle/src/torch/install/bin/torch-activate
