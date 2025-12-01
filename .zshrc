export PATH=$HOME/CompetitiveProgramming/Library:$HOME/.local/bin:$HOME/scripts:$PATH

export EDITOR=nvim
export XDG_CONFIG_HOME="$HOME/.config"

# Set the directory we want to store zinit and plugins
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Download Zinit, if it's not there yet
if [ ! -d "$ZINIT_HOME" ]; then
	mkdir -p "$(dirname $ZINIT_HOME)"
	git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# Source/Load zinit
source "${ZINIT_HOME}/zinit.zsh"

# Add in zsh plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions

# Colors for completion lists:
# - use LS_COLORS for file types
# - ma=... controls how the currently selected item is highlighted
zstyle ':completion:*' list-colors \
  "ma=1;37;45" \
  "${(s.:.)LS_COLORS}"

# Use a menu you can move around in, with a highlighted selection
zstyle ':completion:*' menu select

# Load complist (needed for colored lists + menu selection)
zmodload -i zsh/complist

# Load completions
autoload -Uz compinit && compinit

zinit cdreplay -q

# Prompt
eval "$(oh-my-posh init zsh --config $HOME/.config/ohmyposh/zen.toml)"

# Keybindings
bindkey -e
bindkey '^f' autosuggest-accept
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward
# When the completion menu is active
bindkey -M menuselect '^p' reverse-menu-complete
bindkey -M menuselect '^n' menu-complete

zle_highlight+=(paste:none)

# History
HISTSIZE=10000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# Aliases
alias ls='eza --icons --git'
alias l='ls'
alias ll='ls -l'
alias la='ls -la'
alias lt='ls --tree'
alias cp='cp -i'
alias mv='mv -i'
alias mkdir='mkdir -p'
alias ..='cd ..'

# Competitive Programming
alias asd='g++ -std=gnu++20 -Ofast -o a'
alias dasd='g++ -std=gnu++20 -Ofast -DALE -o a'
alias ddasd='g++ -std=gnu++20 -Wall -Wextra -Wconversion -Wfatal-errors -g -fsanitize=address,undefined -fno-sanitize-recover -O2 -DALE -o a'

# Automatically do an ls after each cd, z, or zoxide
cd ()
{
	if [ -n "$1" ]; then
		builtin cd "$@" && ls
	else
		builtin cd ~ && ls
	fi
}

# Shell integrations
source <(fzf --zsh)
export FZF_DEFAULT_OPTS='--multi --no-height --extended --tmux 100%'
export FZF_DEFAULT_COMMAND='ag --hidden --ignore .git -l -g ""'
export FZF_CTRL_T_OPTS="
  --walker-skip .git,node_modules,target
  --preview 'bat -n --color=always {}'
  --bind 'ctrl-/:change-preview-window(down|hidden|)'"
  # Print tree structure in the preview window
export FZF_ALT_C_OPTS="
  --walker-skip .git,node_modules,target
  --preview 'eza -T -L 1 {}'"

# export NVM_DIR="$HOME/.config/nvm"
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
# [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init - zsh)"
