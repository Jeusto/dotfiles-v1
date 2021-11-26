###############################
###  General configuration  ###
###############################

# Enable Powerlevel10k instant prompt. Should stay close to the top
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Path to oh-my-zsh installation
export ZSH="/home/asaday/.oh-my-zsh"

# Theme
ZSH_THEME="powerlevel10k/powerlevel10k"

# Remind me to update when it's time
zstyle ':omz:update' mode reminder  

# Plugins
plugins=(git copydir copyfile zsh-syntax-highlighting zsh-autosuggestions)

source $ZSH/oh-my-zsh.sh
export PATH=/home/linuxbrew/.linuxbrew/bin/:$PATH

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

[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
