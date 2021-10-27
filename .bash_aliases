# Easier navigation
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."

# Other
alias d="cd ~/Documents/"
alias g="git"

# Enable aliases to be sudo’ed
alias sudo='sudo '

# Empty trash
alias emptytrash="rm -rf ~/.local/share/Trash/*"

# Print each PATH entry on a separate line
alias path="echo -e ${PATH//:/\\n}"

# Valgrind

alias vg='valgrind --leak-check=full --show-leak-kinds=all --track-origins=yes --verbose --log-file=valgrind-out.txt'
