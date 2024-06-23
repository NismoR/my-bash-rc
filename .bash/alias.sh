###############################################################
# Aliases
###############################################################

# Directory navigation
alias ..='cd ..'
alias ..2='cd ../../'
alias ..3='cd ../../../'
alias ..4='cd ../../../../'
alias cs='cd $CODE_SOURCE'
alias cw='cd $WORK_DIR'

# Terminal stuff
alias clr="clear"
alias ó="clear"
alias 0="clear"
alias reload_bash='source ~/.bashrc'
alias gitex='GitExtensions.exe browse [pwd] &'
alias exp='explorer $(pwd|sed "s:/c/:c\:/:"|tr / \\\\) || true'

# Git
alias pu="git pull"
alias br='git branch'
alias co='git checkout'
alias cl='git clone --recurse-submodules -j8'
alias ci='git commit'
alias cia='git commit --amend'
alias cim='git commit --message'
alias di='git diff'
alias dis='git diff --staged'
alias st='git status'
alias sb='git status --short --branch'
alias pull="git pull"
alias push="git push"
alias psh="git push"
alias add="git add"
alias adu="git add --unstaged"
alias log="git log"
alias gll="git log --pretty=short -u -L"
alias gfo="git fetch origin"
alias fo="git fetch origin"
alias grh="git reset --hard"
alias last="git log -1 HEAD"
alias cherry="git cherry -v --abbrev=7"
alias gcp="git cherry-pick -x"

git config --global alias.co checkout
git config --global alias.br branch
git config --global alias.ci commit
git config --global alias.st status
git config --global alias.last 'log -1 HEAD'
