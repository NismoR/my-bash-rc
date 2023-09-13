git() {
    if [ $# -ge 2 ]; then
        if [ "x$1" = "xreset" -a "x$2" = "x--hard" ]; then
            echo "Are you sure? (Type 'yes')"
            read resp || return $?
			if [ "$resp" = "yes" ]; then
				echo "Resetting"
			else				
				echo "NOT Resetting"
				return 0
			fi
        fi
    fi
    command git "$@" || :
}

__git_ps1_user(){
	git config --global user.name
}
__git_ps1_email(){
	git config --global user.email
}

git config --global push.default simple 
git config --global push.followTags true 
git config --global gui.tabsize 4 
#git config --global pull.rebase preserve

alias ..="cd ../"
alias ..2="cd ../../"
alias ..3="cd ../../../"
alias ..4="cd ../../../../"
alias cs="cd $CODE_SOURCE"
alias cw="cd $WORK_DIR"

alias co="git checkout"
alias ci="git commit"
alias cia="git commit --amend"
alias di="git diff"
alias dis="git diff --staged"
alias st="git status"
alias stb="git status -sb"
alias sb="git status -sb"
alias add="git add"
alias adu="git add -u"
alias adp="git add -p"
alias cherry="git cherry -v --abbrev=7"
alias gcp="git cherry-pick -x"
alias gitka="gitk --all"
alias clr="clear"
alias ó="clear"
alias 0="clear"

alias ggb="git gui blame"
alias gll="git log --pretty=short -u -L"

alias gss="git stash save"
alias gsl="git stash list"
alias gsp="git stash pop"
alias rebase="git rebase -ip --autostash"
alias grc="git rebase --continue"
#alias push="git push"
alias gpb="git push -u origin"
alias hard="git reset --hard"
alias exp='explorer $(pwd|sed "s:/c/:c\:/:"|tr / \\\\) || true'
export HISTSIZE=10000
###export PS1="\[\033]0;$TITLEPREFIX:${PWD//[^[:ascii:]]/?}\007\]\n\[\033[32m\]$(__git_ps1_user) \[\033[35m\]\[\033[33m\]\w\[\033[36m\]$(__git_ps1)\[\033[0m\]\n$ "



DEFAULT_COLOR='\[\e[0m\]'
BLACK='\[\e[0;30m\]'
LTBLUE='\[\e[1;34m\]'
LTRED='\[\e[1;31m\]'
LTGREEN='\[\e[1;32m\]'

USER_COLOR=$LTBLUE
GIT_CHANGE_COLOR=$LTRED
GIT_NO_CHANGE_COLOR="$LTRED"

gitPrompt_PS1() {
	local ret=$?
  local gitPrompt=$(__git_ps1)
  local gitUser=$(__git_ps1_user)
  local gitColor="$GIT_NO_CHANGE_COLOR"
  local PS1_n='\[\033]0;`__git_ps1_email` :${PWD//[^[:ascii:]]/?}\007\]' # set window title
	PS1_n="$PS1_n"'\n'                 # new line
	#PS1_n="$PS1_n"'\[\033[32m\]'       # change to green
	PS1_n="$PS1_n"'\[\033[35m\]'       # change to purple
	PS1_n="$PS1_n"'`__git_ps1_user` '             # user@host<space>
	#PS1_n="$PS1_n"'\[\033[35m\]'       # change to purple
	#PS1_n="$PS1_n"'$MSYSTEM '          # show MSYSTEM
	PS1_n="$PS1_n"'\[\033[33m\]'       # change to brownish yellow
	PS1_n="$PS1_n"'\w'                 # current working directory
	if test -z "$WINELOADERNOEXEC"
	then
		GIT_EXEC_PATH="$(git --exec-path 2>/dev/null)"
		COMPLETION_PATH="${GIT_EXEC_PATH%/libexec/git-core}"
		COMPLETION_PATH="${COMPLETION_PATH%/lib/git-core}"
		COMPLETION_PATH="$COMPLETION_PATH/share/git/completion"
		if test -f "$COMPLETION_PATH/git-prompt.sh"
		then
			. "$COMPLETION_PATH/git-completion.bash"
			. "$COMPLETION_PATH/git-prompt.sh"
			if [[ -z $(git status --porcelain 2> /dev/null | tail -n1) ]]; then
				PS1_n="$PS1_n"'\[\033[0;36m\]'  # change color to cyan
			else
				PS1_n="$PS1_n"'\[\033[1;36m\]'  # change color to cyan
			fi
			PS1_n="$PS1_n"'`__git_ps1`'   # bash function
			if [[ -z $(git status --porcelain 2> /dev/null | tail -n1) ]]; then
			  PS1_n="$PS1_n"''
			else
			  PS1_n="$PS1_n"'*'
			fi
		fi
	fi
	
	
	
	if [ $ret -ne 0 ]; then
			PS1_n="$PS1_n"'\[\033[0;31m\]'       # change to red
			PS1_n="$PS1_n"' :('       # change to green
	else
			PS1_n="$PS1_n"'\[\033[0;32m\]'       # change to green
			PS1_n="$PS1_n"' :)'       # change to green
	fi
	
	PS1_n="$PS1_n"'\[\033[0m\]'        # change color
	PS1_n="$PS1_n"'\n'                 # new line
	PS1_n="$PS1_n"'$ '                 # prompt: always $
  
	echo "$PS1_n"
}

PROMPT_COMMAND='PS1="$(gitPrompt_PS1)"'
