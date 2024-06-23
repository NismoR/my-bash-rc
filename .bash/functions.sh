###############################################################
# Functions for Git Bash
###############################################################

# Navigating up on directory based on input
function up()
{   for i in `seq 1 $1`; 
       do cd ../;
    done
}

# Override 'git reset --hard' to ask if you are sure to do the hard reset
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

# Querrying git user data with function
__git_ps1_user(){
	git config user.name
}
__git_ps1_email(){
	git config user.email
}

# Color definitions
DEFAULT_COLOR='\[\e[0m\]'
BLACK='\[\e[0;30m\]'
LTBLUE='\[\e[1;34m\]'
LTRED='\[\e[1;31m\]'
LTGREEN='\[\e[1;32m\]'

USER_COLOR=$LTBLUE
GIT_CHANGE_COLOR=$LTRED
GIT_NO_CHANGE_COLOR="$LTRED"

# New PS1 prompt with git Querrying for dirty branches
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