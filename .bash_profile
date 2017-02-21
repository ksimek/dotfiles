# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# bash style keybindings
set -o vi

# don't put duplicate lines in the history. See bash(1) for more options
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoredups:ignorespace

export CLICOLOR=1

# append to the history file, don't overwrite it
shopt -s histappend
PROMPT_COMMAND="history -a" # save history immediately (don't wait until close)

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=10000
HISTFILESIZE=50000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

export PATH=$HOME/bin:$HOME/scripts:/usr/local/opt/ccache/libexec:/usr/local/bin:$PATH:/usr/local/sbin:$HOME/mp_bin
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$HOME/lib

# KJB
if [[ -e $HOME/.bashrc.kjb ]]; then
    source $HOME/.bashrc.kjb
fi

# MATTERPORT
if [[ -e $HOME/.bashrc.matterport ]]; then
echo sourcing matterport
    source $HOME/.bashrc.matterport
fi




if [[ $HOSTNAME =~ .*MacBook.*  || $HOSTNAME =~ .*mac.* ]]; then
    set meta-flag on
    set input-meta on
    set output-meta on
    set convert-meta off
    export JAVA_HOME=`/usr/libexec/java_home`

# send growl notification to OSX desktop
    growl() { echo -e $'\e]9;'${1}'\007' ; return ; }
fi

export EDITOR=vim
export SVN_EDITOR=vim
export GIT_EDITOR=vim
alias vi=vim

export HOMEBREW_GITHUB_API_TOKEN=aa83d4d56567f5a224766879673e6325d49d5481

set bell-style visible

# for better plotting in octave
#export GNUTERM='aqua'


[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm" # Load RVM function

export PYTHONPATH="/usr/local/lib/python2.7/site-packages:$PYTHONPATH"

if [[ -d ~/.bash_completion.d && $(ls -1 ~/.bash_completion.d  | wc -l) -gt 0 ]]; then
    source ~/.bash_completion.d/*
fi

if [[ -d ~/.bashrc.d && $(ls -1 ~/.bashrc.d | wc -l) -gt 0 ]]; then
    for file in ~/.bashrc.d/*; do
        echo sourcing $file
        source $file
    done
fi

alias tvim='if [[ -e .vimrc ]]; then vim -u .vimrc; else echo "directory has no .vimrc. use ''vim''."; fi'
alias xclip="xclip -selection c"
which nvim > /dev/null 2>&1 && alias vim=nvim
  
  
case "$OSTYPE" in
   cygwin*)
      alias open="cmd /c start"
      ;;
   linux*)
      alias start="xdg-open"
      alias open="xdg-open"
      ;;
   darwin*)
      alias start="open"
      ;;
esac

# DO LAST:
export DYLD_LIBRARY_PATH=$DYLD_LIBRARY_PATH:$LD_LIBRARY_PATH
export EOS_CALDATA_VERSION=v0.5
export EOS_CALDATA_DIR=/home/kyle/mp_calib/vision_caldata/code/

if [[ -e $HOME/bin/A.sh ]]; then 
    alias A="source $HOME/bin/A.sh"
fi

# for ccache:
if [[ -d /usr/local/opt/ccache/libexec ]]; then
    PATH=$PATH:/usr/local/opt/ccache/libexec
fi

test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"
