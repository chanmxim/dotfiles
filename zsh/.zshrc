# -------------------------------------
# Base Options & History
# -------------------------------------
# History Configurations
HISTFILE=~/.zsh_history
HISTSIZE=100
SAVEHIST=100

# Options
setopt auto_cd # Enable auto cd
setopt correct # Enable autocorrect
# export LISTMAX=9999 # Don't ask permission to show large autocomplete list

# -------------------------------------
# Vim Mode 
# -------------------------------------
bindkey -v              # Enable Vim mode
export KEYTIMEOUT=1     # Remove delay when pressing ESC

# -------------------------------------
# Autocompletion System
# -------------------------------------
# Initialize completion system
autoload -Uz compinit
compinit

# Autocomplete hidden files
_comp_options+=(globdots)

# Enable interactive selection
zstyle ':completion:*' menu select

# Styling and grouping
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-dirs-first true
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*' group-name ''
zstyle ':completion:*:descriptions' format '%B-- %d --%b'
zstyle ':completion:*:warnings' format '%F{yellow}-- no matches found --%f'

# Enable vim keys for navigating interactive menu
zmodload zsh/complist
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -M menuselect 'l' vi-forward-char

# -------------------------------------
# Aliases 
# -------------------------------------
alias ls='ls --color=auto --group-directories-first'

# -------------------------------------
# Prompt & Plugins
# -------------------------------------
# Initialize Starship prompt
eval "$(starship init zsh)"

# Enable zsh-syntax-highlighting
# source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
