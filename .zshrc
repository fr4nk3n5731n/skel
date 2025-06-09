# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

autoload -U select-word-style
select-word-style bash

#!/usr/bin/env zsh
source "${HOME}/.antidote/antidote.zsh"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

antidote load

# ctrl+arrow_left
bindkey "^[[1;5D" backward-word
# ctrl+arrow_right
bindkey "^[[1;5C" forward-word
# ctrl+del
bindkey '^H' backward-kill-word
# ctrl+backspace
bindkey '^[[3;5~' kill-word

function pushy() {
	git push origin $(git branch --show-current) "$@"
}

function pully() {
	git pull origin $(git branch --show-current) "$@"
}

function rebasey() {
	git rebase "origin/$(git branch --show-current)" "$@"
}

function fix_sys_python() {
	sudo pacman -S --noconfirm $(pacman -Qq | grep -Eo "^python-.*")
}

HISTFILE=~/.zsh_history
HISTSIZE=1000
SAVEHIST=1000
setopt appendhistory

# stuff for arrow up/down search for started lines
autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey "^[[A" up-line-or-beginning-search
bindkey "^[[B" down-line-or-beginning-search

export PATH="${PATH}:${HOME}/bin"
