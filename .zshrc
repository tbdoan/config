# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

if [[ -f "/opt/homebrew/bin/brew" ]] then
  # If you're using macOS, you'll want this enabled
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Set the directory we want to store zinit and plugins
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Download Zinit, if it's not there yet
if [ ! -d "$ZINIT_HOME" ]; then
   mkdir -p "$(dirname $ZINIT_HOME)"
   git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# Source/Load zinit
source "${ZINIT_HOME}/zinit.zsh"

# Add in Powerlevel10k
zinit ice depth=1; zinit light romkatv/powerlevel10k

# Add in zsh plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab

# Add in snippets
zinit snippet OMZL::git.zsh
zinit snippet OMZP::git
zinit snippet OMZP::sudo
zinit snippet OMZP::archlinux
zinit snippet OMZP::aws
zinit snippet OMZP::kubectl
zinit snippet OMZP::kubectx
zinit snippet OMZP::command-not-found

# Load completions
autoload -Uz compinit && compinit

zinit cdreplay -q

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Keybindings
bindkey -e
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward
bindkey '^[w' kill-region

# History
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=4000
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

# Aliases
alias ls='ls --color'
alias c='clear'
alias fk='hist d -1 > /dev/null'

# Shell integrations
eval "$(fzf --zsh)"
eval "$(zoxide init --cmd cd zsh)"

# BEGIN https://github.com/Imprint-Tech/go-backend/blob/main/scripts/prepare-env.sh: Home binary install dir
#
# Add $HOME/bin to path
#
#
path=("/Users/tbdoan/bin" $path)
#
# END https://github.com/Imprint-Tech/go-backend/blob/main/scripts/prepare-env.sh: Home binary install dir



# BEGIN https://github.com/Imprint-Tech/go-backend/blob/main/scripts/prepare-env.sh: Go setup
#
# Setup custom Go install environment variables and prepend GOPATH and GOROOT binaries to PATH.
#
export GOPATH="$HOME/go"
export GOROOT="$(go env GOROOT)"
export PATH="${GOPATH}/bin:$PATH"
export GOEXPERIMENT="loopvar"
#
# END https://github.com/Imprint-Tech/go-backend/blob/main/scripts/prepare-env.sh: Go setup



#
# Define PKG_CONFIG_PATH to locate libcrypto.pc
#
# Installed by https://github.com/Imprint-Tech/go-backend/blob/main/scripts/prepare-env.sh
#
export PKG_CONFIG_PATH="/opt/homebrew/opt/openssl@3/lib/pkgconfig"

# https://github.com/marlonrichert/zsh-hist
source /Users/tbdoan/Documents/Personal/configs/zsh-hist/zsh-hist.plugin.zsh
