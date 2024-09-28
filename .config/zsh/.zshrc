bindkey -e
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word
setopt AUTO_CD

autoload -U compinit; compinit
_comp_options+=(globdots)
source $HOME/.config/zsh/completion.zsh

autoload -U colors; colors
PS1="%B%{$fg[red]%}%n%{$fg[white]%}@%{$fg[yellow]%}%M %{$fg[magenta]%}%~"$'\n'"%{$fg[blue]%}$%{$reset_color%}%b "

source /home/alls/.config/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /home/alls/.config/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

bindkey '^f' autosuggest-accept

HISTSIZE=10000
SAVEHIST=$HISTSIZE
HISTFILE=$HOME/.config/zsh/history
HISTDUP=erase
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

alias ls='eza --icons'
alias l='ls -l'
alias la='ls -la'
alias lt='ls --tree'
alias v='nvim'
alias asd='g++ -std=gnu++20 -Ofast -o a'
alias dasd='g++ -std=gnu++20 -Ofast -DALE -o a'
alias ddasd='g++ -std=gnu++20 -Wall -Wextra -g -fsanitize=address -fsanitize=undefined -fno-sanitize-recover -O2 -DALE -o a'
alias cpc='xclip -sel c < '