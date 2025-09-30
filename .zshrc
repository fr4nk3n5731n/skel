#!/usr/bin/env zsh
# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

autoload -U select-word-style
select-word-style bash
autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

if test -f "${HOME}/.antidote/antidote.zsh"; then
	source "${HOME}/.antidote/antidote.zsh"
elif test -f "/usr/share/zsh-antidote/antidote.zsh"; then
	source "/usr/share/zsh-antidote/antidote.zsh"
else
	echo "ERROR: can't find antidote"
fi

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

antidote load

## QoL FUNCTIONS
#push to current branch on remote
function pushy() {
	git push origin $(git branch --show-current) "$@"
}
#pull from current branch on remote
function pully() {
	git pull origin $(git branch --show-current) "$@"
}
#rebase from current branch on remote
function rebasey() {
	git rebase "origin/$(git branch --show-current)" "$@"
}
#fix system python install in case of the inevitable breakage 
function fix_sys_python() {
	sudo pacman -S --noconfirm $(pacman -Qq | grep -Eo "^python-.*")
}

## HISTORY
HISTFILE=~/.zsh_history
HISTSIZE=1000
SAVEHIST=1000
setopt appendhistory

## KEYBINDS
#grouped deletion
bindkey '^H' backward-kill-word  # ctrl+del
bindkey '^[[3;5~' kill-word  # ctrl+backspace
#history search
bindkey "^[[A" up-line-or-beginning-search
bindkey "^[[B" down-line-or-beginning-search
#cursor movement
bindkey  "^[[H"   beginning-of-line
bindkey  "^[[F"   end-of-line
bindkey  "^[[3~"  delete-char
bindkey "^[[1;5D" backward-word  # ctrl+arrow_left
bindkey "^[[1;5C" forward-word  # ctrl+arrow_right

## EXPORTS
export PATH="${PATH}:${HOME}/bin"
