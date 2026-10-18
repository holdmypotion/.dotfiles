# Machine-local pre-init hook (must run before p10k-instant-prompt if wrapping shell with `exec`)
[[ -f "$HOME/.zshrc_private/.zsh_pre" ]] && source "$HOME/.zshrc_private/.zsh_pre"

# p10k-instant-prompt

if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export ZSH="$HOME/.oh-my-zsh"
export EDITOR='nvim'
ZSH_THEME="powerlevel10k/powerlevel10k"

plugins=(
  git
  zsh-syntax-highlighting
  zsh-autosuggestions
  dirhistory
  fzf-tab
)
(( $+commands[aws] )) && plugins+=(aws)


fpath+=${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-completions/src

# ZSH Plugins Config
bindkey '^ ' autosuggest-accept ## disable sort when completing `git checkout`

zstyle ':completion:*:git-checkout:*' sort false
## set descriptions format to enable group support
## NOTE: don't use escape sequences here, fzf-tab will ignore them
zstyle ':completion:*:descriptions' format '[%d]'
## set list-colors to enable filename colorizing
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
## force zsh not to show completion menu, which allows fzf-tab to capture the unambiguous prefix
zstyle ':completion:*' menu no
## preview directory's content with eza when completing cd
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --color=always $realpath'
## switch group using `<` and `>`
zstyle ':fzf-tab:*' switch-group '<' '>'

source $ZSH/oh-my-zsh.sh

if [[ "$OSTYPE" == "darwin"* ]]; then
  intel() {
    arch -x86_64 "$@"
  }
fi

[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

mtr='PATH=/usr/local/sbin:$PATH sudo mtr'

# Keep PATH entries unique (prevents duplicate entries across tmux and nested shells)
typeset -U path PATH
path=(${path%/})

export PATH="$HOME/.local/bin:$PATH"

if [[ -f "$HOME/.config/fabric/fabric-bootstrap.inc" ]]; then
  . "$HOME/.config/fabric/fabric-bootstrap.inc"
fi

alias cpd='find ~/workspace/downloads/ | fzf | xargs -I {} cp {} .'

alias ls='eza --icons=always'
command -v zoxide >/dev/null 2>&1 && eval "$(zoxide init --cmd cd zsh)"

export SCRIPTS="$HOME/.zshrc_public/.scripts"
export PATH="$PATH:$SCRIPTS"

[[ -d "$HOME/.console-ninja/.bin" ]] && export PATH="$HOME/.console-ninja/.bin:$PATH"

# pnpm
if [[ "$OSTYPE" == "darwin"* ]]; then
  export PNPM_HOME="$HOME/Library/pnpm"
else
  export PNPM_HOME="${XDG_DATA_HOME:-$HOME/.local/share}/pnpm"
fi
if [[ -d "$PNPM_HOME" ]]; then
  case ":$PATH:" in
    *":$PNPM_HOME:"*) ;;
    *) export PATH="$PNPM_HOME:$PATH" ;;
  esac
fi
# pnpm end

# opencode
[[ -d "$HOME/.opencode/bin" ]] && export PATH="$HOME/.opencode/bin:$PATH"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
[[ -s "$HOME/.avn/bin/avn.sh" ]] && source "$HOME/.avn/bin/avn.sh" # load avn
if [[ -d "/opt/homebrew/opt/nvm" ]]; then
  brew_nvm_prefix="/opt/homebrew/opt/nvm"
elif [[ -d "/usr/local/opt/nvm" ]]; then
  brew_nvm_prefix="/usr/local/opt/nvm"
elif command -v brew >/dev/null 2>&1; then
  brew_nvm_prefix="$(brew --prefix nvm 2>/dev/null)"
fi
if [[ -n "$brew_nvm_prefix" ]]; then
  [ -s "$brew_nvm_prefix/nvm.sh" ] && \. "$brew_nvm_prefix/nvm.sh"
  [ -s "$brew_nvm_prefix/etc/bash_completion.d/nvm" ] && \. "$brew_nvm_prefix/etc/bash_completion.d/nvm"
  unset brew_nvm_prefix
fi

for file in $HOME/.zshrc_public/*(ND.) $HOME/.zshrc_private/*(ND.); do
  [[ "${file:t}" == ".zsh_pre" ]] && continue
  source "$file"
done
