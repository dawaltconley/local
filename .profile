export PATH=$PATH:$HOME/bin
eval "$(rbenv init -)"
export NVM_DIR=~/.nvm
source $(brew --prefix nvm)/nvm.sh

#
# Run 'nvm use' automatically every time there's
# a .nvmrc file in the directory. Also, revert to default
# version when entering a directory without .nvmrc
#

function check_nvm {
if [[ $PWD == $PREV_PWD ]]; then
    return
fi

PREV_PWD=$PWD
if [[ -f ".nvmrc" ]]; then
    nvm use
    NVM_DIRTY=true
elif [[ $NVM_DIRTY = true ]]; then
    nvm use default
    NVM_DIRTY=false
fi
}

export PROMPT_COMMAND=check_nvm
check_nvm
