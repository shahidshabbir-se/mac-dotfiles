# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# --------------------#
#      Exports        #
# --------------------#
export EDITOR='nvim'
export SUDO_PROMPT="Deploying root access for %u. Password pls: "
export PATH=$PATH:/home/shahid/.spicetify
export NVM_DIR="$HOME/.nvm"
export PATH="/run/current-system/sw/bin:$PATH"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# --------------------#
#      Zinit Setup    #
# --------------------#
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ ! -d "$ZINIT_HOME" ] && mkdir -p "$(dirname "$ZINIT_HOME")"
[ ! -d "$ZINIT_HOME/.git" ] && git clone --depth 1 https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "${ZINIT_HOME}/zinit.zsh"

# --------------------#
#      Plugins        #
# --------------------#
zinit snippet OMZL::git.zsh
zinit snippet OMZP::git
zinit snippet OMZP::sudo
zinit snippet OMZP::command-not-found
plugins=(
  zdharma-continuum/fast-syntax-highlighting
  zsh-users/zsh-completions
  zsh-users/zsh-autosuggestions
  Aloxaf/fzf-tab
  romkatv/powerlevel10k
)
for plugin in "${plugins[@]}"; do
  zinit ice depth"1"
  zinit light "$plugin"
done

# --------------------#
#      External Tools   #
# --------------------#
eval "$(atuin init zsh --disable-up-arrow)"
eval "$(fzf --zsh)"
eval "$(zoxide init --cmd cd zsh)"

# --------------------#
#    Dot Style        #
# --------------------#
expand-or-complete-with-dots() {
  echo -n "\e[31m…\e[0m"
  zle expand-or-complete
  zle redisplay
}
zle -N expand-or-complete-with-dots
bindkey "^I" expand-or-complete-with-dots

# -------------------#
#      History      #
# -------------------#
HISTFILE=~/.config/zsh/zhistory
HISTSIZE=5000
SAVEHIST=5000
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# --------------------#
#      Options        #
# --------------------#
setopt AUTOCD              # change directory just by typing its name
setopt PROMPT_SUBST        # enable command substitution in prompt
setopt MENU_COMPLETE       # Automatically highlight first element of completion menu
setopt LIST_PACKED		   # The completion menu takes less space.
setopt AUTO_LIST           # Automatically list choices on ambiguous completion.
setopt COMPLETE_IN_WORD    # Complete from both ends of a word.

# --------------------#
#      Keybinds       #
# --------------------#
bindkey '^r' atuin-search
bindkey '^[[A' atuin-up-search
bindkey '^[OA' atuin-up-search
bindkey '^A' beginning-of-line
bindkey '^E' end-of-line
bindkey '^U' backward-kill-line
bindkey '^K' kill-line
bindkey '^W' backward-kill-word
bindkey '^[b' backward-word
bindkey '^[f' forward-word
bindkey '^D' delete-char
bindkey '^?' backward-delete-char
bindkey '^T' transpose-chars
bindkey '^[t' transpose-words
bindkey '^Y' yank
bindkey '^[o' execute-named-cmd
bindkey '^F' autosuggest-accept

# --------------------#
#      Aliases        #
# --------------------#
alias mirrors="sudo reflector --verbose --latest 5 --country 'United States' --age 6 --sort rate --save /etc/pacman.d/mirrorlist"
alias update="paru -Syu --nocombinedupgrade"
alias grub-update="sudo grub-mkconfig -o /boot/grub/grub.cfg"

alias music="ncmpcpp"
alias bc="better-commits"
alias cat="bat --theme=base16"
alias ls='eza --icons=always --color=always -a'
alias ll='eza --icons=always --color=always -la'
alias rm="rm -rf"
alias c="clear"
alias lt="eza --tree --level=2 --long --icons --git"
alias ltree="eza --tree --level=2 --icons --git"
alias v="nvim"
alias ..="cd .."
alias e="exit"
alias copy="xclip -selection clipboard"

# Git aliases
alias gs="git status"
alias glog="git log --oneline --graph --decorate"
alias gc="git commit -m"
alias gca="git commit -a -m"
alias gp="git push origin HEAD"
alias gpu="git pull origin"
alias gdiff="git diff"
alias gco="git checkout"
alias gb="git branch"
alias gba="git branch -a"
alias gadd="git add"
alias ga="git add -p"
alias gcoall="git checkout -- ."
alias gr="git remote"
alias gre="git reset"
alias ggr="git-graph --model git-flow"

# LazyGit alias
alias lzg="lazygit"

# pnpm aliases
alias pi="pnpm install"
alias pd="pnpm install --save-dev"
alias pr="pnpm run dev"
alias ps="pnpm start"
alias pt="pnpm test"

# Docker aliases
alias d="docker"
alias dc="docker compose"
alias dco="docker compose"
alias dcu="docker compose up"
alias dcd="docker compose down"
alias dps="docker ps"
alias dpa="docker ps -a"
alias dl="docker ps -l -q"
alias di="docker images"
alias dr="docker run"
alias dp="docker pull"
alias dx="docker exec -it"
alias lzd="lazydocker"

# --------------------#
#      Functions      #
# --------------------#
alias gcs="function _gitclone() { git clone git@github.com:shahidshabbir-se/\$1.git; }; _gitclone"
alias gch="function _gch() { if [[ -n \$1 && \$1 =~ ^[0-9]+$ ]]; then git clone --depth \$1 \$2; else git clone \$1; fi; }; _gch"
extract() {
  if [ -f "$1" ]; then
    case "$1" in
      *.tar.bz2)   tar xvjf "$1"   ;;
      *.tar.gz)    tar xvzf "$1"   ;;
      *.bz2)       bunzip2 "$1"    ;;
      *.rar)       unrar x "$1"    ;;
      *.gz)        gunzip "$1"     ;;
      *.tar)       tar xvf "$1"    ;;
      *.tbz2)      tar xvjf "$1"   ;;
      *.tgz)       tar xvzf "$1"   ;;
      *.zip)       unzip "$1"      ;;
      *.Z)         uncompress "$1" ;;
      *.7z)        7z x "$1"       ;;
      *)           echo "'$1' cannot be extracted" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

export PATH=$PATH:/Users/shahid/.spicetify
