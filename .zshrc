
HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000
setopt SHARE_HISTORY

export PATH=~/bin:$PATH

string=$(uname -a)
if [[ $string = *"x86_64"* ]]; then # linux
	[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
elif [[ $string = *"amd64"* ]]; then # freeBSD
	[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
else # arm64
[ -f ~/.fzf.arm64.zsh ] && source ~/.fzf.arm64.zsh
fi

## get dhms from seconds
function displaytime() {
  local T=$1
  local D=$((T/60/60/24))
  local H=$((T/60/60%24))
  local M=$((T/60%60))
  local S=$((T%60))
  [[ $D > 0 ]] && printf '%dd' $D
  [[ $H > 0 ]] && printf '%dh' $H
  [[ $M > 0 ]] && printf '%dm' $M
  printf '%ds\n' $S
}

export BASE_PS1="%?:%m:%1/"

function preexec() {
	pre_exec_time=$(date +%s)
}

function precmd() {
    git branch 2> /dev/null 1> /dev/null
    if [ $? -eq 0 ];
    then
        git_branch="@$(git branch | grep "*" | cut -d ' ' -f 2)"
    fi
    if [ $pre_exec_time ];
    then
        post_exec_time=$(date +%s)
        diff_exec_time=$(($post_exec_time - $pre_exec_time))
        if [ $diff_exec_time -gt 0 ]; 
        then
            export PROMPT="[${BASE_PS1}${git_branch}:$(displaytime ${diff_exec_time})] "
        else
            export PROMPT="[$BASE_PS1${git_branch}] "
        fi
        unset pre_exec_time
    else
        export PROMPT="[$BASE_PS1]${git_branch} "
    fi
    unset git_branch
}

# https://forums.freebsd.org/threads/share-your-zshrc-file.62653/
# del key
bindkey '\e[3~' delete-char
# end/home
bindkey '\e[1~' beginning-of-line
bindkey '\e[4~' end-of-line
bindkey '\e[H' beginning-of-line
bindkey '\e[F' end-of-line
# pgup/pgdown
bindkey '\e[5~' up-line-or-history
bindkey '\e[6~' down-line-or-history

# list dir with TAB, when there are only spaces/no text
# before cursor, or complete text, that is before cursor only
_nice_autolist() { if [[ -z ${LBUFFER// } ]]
	then BUFFER='ls ' CURSOR=3 zle list-choices
	zle end-of-list
	else zle expand-or-complete-prefix; fi }
zle -N _nice_autolist
bindkey '\CI' _nice_autolist

# startx if on ttyv0
if [ $(tty) = "/dev/ttyv0" ]; then
	startx
fi

