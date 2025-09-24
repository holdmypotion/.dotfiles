# p10k-instant-prompt

if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export ZSH="$HOME/.oh-my-zsh"
export EDITOR='vim'
ZSH_THEME="powerlevel10k/powerlevel10k"

plugins=(
  git
  zsh-syntax-highlighting
  zsh-autosuggestions
  aws
  dirhistory
  fzf-tab
)


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

intel() {
  arch -x86_64 $@
}


[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

mtr='PATH=/usr/local/sbin:$PATH sudo mtr'

export PATH="$PATH:/Users/loona-mac/.local/bin"


if [ -f "/Users/loona-mac/.config/fabric/fabric-bootstrap.inc" ]; then . "/Users/loona-mac/.config/fabric/fabric-bootstrap.inc"; fi

alias cpd='find ~/workspace/downloads/ | fzf | xargs -I {} cp {} .'

alias ls='eza --icons=always'
eval "$(zoxide init --cmd cd zsh)"

export SCRIPTS="$HOME/.zshrc_public/.scripts/"
export PATH="$PATH:$SCRIPTS"


PATH=~/.console-ninja/.bin:$PATH
# pnpm
export PNPM_HOME="/Users/loona-mac/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

# opencode
export PATH=/Users/loona-mac/.opencode/bin:$PATH

for file in $HOME/.zshrc_*/*(ND.); do
  source "$file"
done

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
[[ -s "$HOME/.avn/bin/avn.sh" ]] && source "$HOME/.avn/bin/avn.sh" # load avn
export NVM_DIR="$HOME/.nvm"
[ -s "$(brew --prefix nvm)/nvm.sh" ] && \. "$(brew --prefix nvm)/nvm.sh"
[ -s "$(brew --prefix nvm)/etc/bash_completion.d/nvm" ] && \. "$(brew --prefix nvm)/etc/bash_completion.d/nvm"

# Created by `pipx` on 2025-07-31 06:44:34
export PATH="$PATH:/Users/rahul/.local/bin"
