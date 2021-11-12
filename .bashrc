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

export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

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

#################
###  Aliases  ###
#################

alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'

# Other
alias t="cd ~/Téléchargements/"
alias g="git"

# Enable aliases to be sudo’ed
alias su='sudo '

# Empty trash
alias emptytrash="rm -rf ~/.local/share/Trash/*"

# Print each PATH entry on a separate line
alias path="echo -e ${PATH//:/\\n}"

# Valgrind
alias vg='valgrind --leak-check=full --show-leak-kinds=all --track-origins=yes --verbose --log-file=valgrind-out.txt'

# Search through command history
alias hs='history | grep'

# Sort by file size
alias lt='ls --human-readable --size -1 -S --classify'

###################
###  Functions  ###
###################

# Make a folder and go into it
mkcd() { mkdir -p $1; cd $1 }

# Install a theme
installtheme() {
  bash -c  "$(wget -qO- https://git.io/vQgMr)"
}

# Git pull in all valid subdirectories 
pullall() {
  for dir in ./*/
    do
      cd ${dir}
      git status >/dev/null 2>&1
      # check if exit status of above was 0, indicating we're in a git repo
      [ $(echo $?) -eq 0 ] && echo "Updating ${dir%*/}..." && git pull
      cd ..
    done
}

# Change directories and view the contents
cl() {
    DIR="$*";
        # if no DIR given, go home
        if [ $# -lt 1 ]; then
                DIR=$HOME;
    fi;
    builtin cd "${DIR}" && \
    # use your preferred ls command
        ls -F --color=auto
}

# Count number of files in directory
numfiles() { 
    N="$(ls $1 | wc -l)"; 
    echo "$N files in $1";
}

# Upload and share text or code file
sharecode() {
    file="$1"
    (cat "$1" | curl -F 'f:1=<-' ix.io) | sed "s/$/\/${file##*.}/" | xclip -selection clipboard;
}
sharetxt() {
    (cat "$1" | curl -F 'f:1=<-' ix.io) | xclip -selection clipboard;
}

# Upload and transfer all types of file (max 5gb)
transfer() { 
    if [ $# -eq 0 ];then echo "No arguments specified.\nUsage:\n transfer <file|directory>\n ... | transfer <file_name>">&2;return 1;fi;if tty -s;then file="$1";file_name=$(basename "$file");if [ ! -e "$file" ];then echo "$file: No such file or directory">&2;return 1;fi;if [ -d "$file" ];then file_name="$file_name.zip" ,;(cd "$file"&&zip -r -q - .)|curl --progress-bar --upload-file "-" "https://transfer.sh/$file_name"|tee /dev/null,;else cat "$file"|curl --progress-bar --upload-file "-" "https://transfer.sh/$file_name"|tee /dev/null;fi;else file_name=$1;curl --progress-bar --upload-file "-" "https://transfer.sh/$file_name"|tee /dev/null;fi;
}

#######################
###  Curl commands  ###
#######################

# Test internet speed
speedtest() {
    curl -s https://raw.githubusercontent.com/sivel/speedtest-cli/master/speedtest.py | python3 -;
}

# Get info about current ip
ip() {
    curl https://ipinfo.io/json; 
}

# Expand a short url
expand() {
    curl -sIL "$1" | grep -i ^location;
}

# Grab a qr code
qrcode() {
    curl qrenco.de/"$1";
}

# Get the current weather
weather() {
    curl https://v2.wttr.in/"$1";
}

# Get random numbers
random() {
    curl "https://www.random.org/integers/?num=${1:-1}&min=${2:-1}&max=${3:-100}&col=1&base=10&format=plain&rnd=new"
}

# Extract all links from a page
alllinks() {
  curl -s "https://api.hackertarget.com/pagelinks/?q=$1"
}

# Fetch the latest news
news() {
  query=""
  for ARG in "$@"
  do
    query="${query}+$ARG"
  done
  curl getnews.tech/${query}
}

# Speed test
speedtest() {
  curl -s https://raw.githubusercontent.com/sivel/speedtest-cli/master/speedtest.py | python3 -
}

###############
###  Other  ###
###############


