###############################
###  General configuration  ###
###############################

# Enable Powerlevel10k instant prompt. Should stay close to the top
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi
ZLE_RPROMPT_INDENT=0

# Path to oh-my-zsh installation
export ZSH="/home/asaday/.oh-my-zsh"

# Theme
ZSH_THEME="powerlevel10k/powerlevel10k"

# Remind me to update when it's time
zstyle ':omz:update' mode reminder  

# Plugins
plugins=(git zsh-syntax-highlighting zsh-autosuggestions)

source $ZSH/oh-my-zsh.sh
export PATH=/home/linuxbrew/.linuxbrew/bin/:$PATH

#################
###  Aliases  ###
#################

alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
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

# Show files sorted by size
alias lt='ls --human-readable --size -1 -S --classify'


###################
###  Functions  ###
###################

# Copy current directory into clipboard
copydir() {
  DIR=$(pwd)
  echo "Copied current directory into clipboard: $DIR"; pwd | xclip -selection clipboard 
}

# Copy file content into clipboard
copyfile() {
  echo "Copied file content into clipboard: $1"; cat $1 | xclip -selection clipboard 
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

# Upload and share formatted code file
sharecode() {
    file="$1"
    (cat "$1" | curl -F 'f:1=<-' ix.io) | sed "s/$/\/${file##*.}/" | xclip -selection clipboard;
}

# Upload and share text file
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

# Cheat.sh
ch() {
    curl cht.sh/$1
}

# Test internet speed
speedtest() {
    curl -s https://raw.githubusercontent.com/sivel/speedtest-cli/master/speedtest.py | python3 -;
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

###############
###  Other  ###
###############

[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
