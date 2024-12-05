# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

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
    xterm-color|*-256color) color_prompt=yes;;
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

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'


alias xclip='xclip -selection clipboard'

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

export PATH=$PATH:$HOME/.local/bin

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export BASIS_POSTGRES_PORT=5432
export BASIS_POSTGRES_USER=$USER


# virtual environment config from onboarding docs
export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python3
export WORKON_HOME=$HOME/.virtualenvs
source $HOME/.local/bin/virtualenvwrapper.sh


_set_prompt () {
    reset=$(tput sgr0)
    dark_gray=$(tput setaf 0)
    bold_dark_gray=$(tput setaf bold)$dark_gray
    red=$(tput setaf 1)
    bold_red=$(tput setaf bold)$dark_red
    green=$(tput setaf 2)
    bold_green=$(tput setaf bold)$green
    yellow=$(tput setaf 3)
    bold_yellow=$(tput setaf bold)$yellow
    blue=$(tput setaf 4)
    bold_blue=$(tput setaf bold)$blue
    purple=$(tput setaf 5)
    bold_purple=$(tput setaf bold)$purple
    turquoise=$(tput setaf 6)
    bold_turquoise=$(tput setaf bold)$turquoise
    light_gray=$(tput setaf 7)
    bold_light_gray=$(tput setaf bold)$light_gray

    function join_by {
      local d=${1-} f=${2-}
      if shift 2; then
        printf %s "$f" "${@/#/$d}"
      fi
    }

    HOSTPS1="\[$blue\]\h\[$reset\]"
    JOBSC=$(jobs | wc -l)
    if [ "$JOBSC" != "0" ]; then
        HOSTPS1="$HOSTPS1\[$yellow\]%$JOBSC\[$reset\]"
    fi

    PS1="\[$turquoise\]\u\[$reset\]@$HOSTPS1\[$bold_dark_gray\]:\[$reset\]\[$bold_green\]\w\[$reset\]\$ "

    if [ -n "$VIRTUAL_ENV" ]; then
        VENVPS1=$(printf "\[$bold_yellow\]%s\[$reset\]" $(basename $VIRTUAL_ENV))
    else
        unset VENVPS1
    fi

    GITBR=$(git branch 2>/dev/null)
    if [ -n "$GITBR" ]; then
        if [ -z "$(git ls-files -m)" ]; then
            GITCOLOR=$green
        else
            GITCOLOR=$red
        fi
        GITPS1="\[$GITCOLOR\]\$(git branch 2>/dev/null | grep '^*' | colrm 1 2)\[$reset\]"

        STASH=$(git stash list | wc -l)
        if [ "$STASH" != "0" ]; then
            GITPS1="$GITPS1$(printf "\[$bold_dark_gray\][\[$reset\]\[$bold_purple\]%s\[$reset\]\[$bold_dark_gray\]]\[$reset\]" $STASH)"
        fi
    else
        unset GITPS1
    fi

    if [[ -n "$GITPS1" || -n "$VENVPS1" ]]; then
        STATUS=$(join_by "\[$bold_dark_gray\]|\[$reset\]" "$VENVPS1" "$GITPS1")
        PS1="\[$bold_dark_gray\]{\[$reset\]$STATUS\[$bold_dark_gray\]}\[$reset\] $PS1"
    fi
}
PROMPT_COMMAND=_set_prompt


export PAGER="less -S"

# direnv entry for jesse
eval "$(direnv hook bash)"
EDITOR=vim



