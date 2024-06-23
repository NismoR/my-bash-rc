###############################################################
# Bash RC Settings
###############################################################

#!/usr/bin/env bash
# ${HOME}/.bashrc: executed by bash(1) for non-login shells.
# If not running, don't do anything
[ -z "$PS1" ] && return

# Loading bash files
source ~/.bash/alias.sh
source ~/.bash/default_settings.sh
source ~/.bash/functions.sh

# Overriding original PS1 prompt
PROMPT_COMMAND='PS1="$(gitPrompt_PS1)"'