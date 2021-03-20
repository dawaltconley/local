export PATH=$PATH:$HOME/bin
export PATH=/usr/local/opt/openvpn/sbin:$PATH
eval "$(rbenv init -)"
export NVM_DIR=~/.nvm
export VISUAL=/usr/local/bin/vim
export SAM_CLI_TELEMETRY=0
source $(brew --prefix nvm)/nvm.sh

HISTTIMEFORMAT="%d/%m/%y %l:%M:%S %p "

alias powershell=pwsh
alias resolve='vim $( git diff --name-only --diff-filter=U | uniq ) +"/<\{7}" +"normal zz"'
alias soffice=/Applications/LibreOffice.app/Contents/MacOS/soffice

stty -ixon # turn off flow control
