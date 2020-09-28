export PATH=$PATH:$HOME/bin
eval "$(rbenv init -)"
export NVM_DIR=~/.nvm
export VISUAL=/usr/local/bin/vim
source $(brew --prefix nvm)/nvm.sh

HISTTIMEFORMAT="%d/%m/%y %l:%M:%S %p "

alias powershell=pwsh
alias resolve='vim $( git diff --name-only --diff-filter=U | uniq ) +"/<\{7}" +"normal zz"'

stty -ixon # turn off flow control
