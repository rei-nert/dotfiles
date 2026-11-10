# ─── History ─────────────────────────────────────────────────────
HISTFILE=~/.zsh_history
export HISTSIZE=1000000000
export SAVEHIST=$HISTSIZE
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_SAVE_NO_DUPS
setopt HIST_VERIFY
setopt SHARE_HISTORY
setopt INC_APPEND_HISTORY
setopt EXTENDED_HISTORY

# ─── Shell Options ───────────────────────────────────────────────
setopt EXTENDED_GLOB        # **, ~, ^ patterns
setopt GLOB_DOTS            # include dotfiles in globs
setopt NO_CASE_GLOB         # case-insensitive globbing
setopt CORRECT              # command correction
setopt INTERACTIVE_COMMENTS # allow # comments in CLI
setopt NO_BEEP
setopt autocd
set -o vi

bindkey -v '^?' backward-delete-char
# ─── Keybindings ─────────────────────────────────────────────────
# ─── Completion ──────────────────────────────────────────────────
autoload -Uz compinit
compinit -C
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'  # case-insensitive
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*:*:*:*:*' menu select
zstyle ':completion::complete:*' gain-privileges 1

# sudo/doas completion
compdef _sudo sudo
compdef _sudo doas


zstyle ':completion:*' rehash true

# ─── Dircolors ───────────────────────────────────────────────────
if [[ -r ~/.dircolors ]]; then
  eval "$(dircolors -b ~/.dircolors)"
else
  eval "$(dircolors -b)"
fi

# ─── Less Colors ─────────────────────────────────────────────────
export LESS_TERMCAP_mb=$'\e[35m'  # magenta
export LESS_TERMCAP_md=$'\e[33m'  # yellow
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_so=$'\e[34m'  # blue
export LESS_TERMCAP_ue=$'\e[0m'
export LESS_TERMCAP_us=$'\e[4m'   # underline

# ─── Lesspipe ────────────────────────────────────────────────────
if (( $+commands[lesspipe] )); then
  export LESSOPEN="| /usr/bin/lesspipe %s"
  export LESSCLOSE="/usr/bin/lesspipe %s %s"
fi

source <(fzf --zsh)
eval "$(starship init zsh)"

### Added by Zinit's installer
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi

source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zdharma-continuum/zinit-annex-as-monitor \
    zdharma-continuum/zinit-annex-bin-gem-node \
    zdharma-continuum/zinit-annex-patch-dl \
    zdharma-continuum/zinit-annex-rust

zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-autosuggestions

### End of Zinit's installer chunk
#
#
# ─── Utility Functions ───────────────────────────────────────────
_have() { (( $+commands[$1] )); }
_source_if() { [[ -r $1 ]] && source $1; }

# dwm reload
dwm-reload() {
  kill -HUP "${$(pgrep -o dwm 2>/dev/null):-}" 2>/dev/null || echo "dwm not running"
}

# ─── Xresources ──────────────────────────────────────────────────
[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources

# ─── Prompt: Starship ────────────────────────────────────────────
if _have starship; then
  eval "$(starship init zsh)"
fi

# ─── Zoxide ──────────────────────────────────────────────────────
if _have zoxide; then
  eval "$(zoxide init zsh)"
fi

# ─── Mise ────────────────────────────────────────────────────────
if [[ -x $HOME/.local/bin/mise ]]; then
  eval "$(mise activate zsh)"
fi

# ─── NNN ─────────────────────────────────────────────────────────
if _have nnn; then
  export NNN_OPTS="deH"
  export LC_COLLATE="C"
  export NNN_FIFO="/tmp/nnn.fifo"
  export NNN_FCOLORS="AAAAE631BBBBCCCCDDDD9999"
  export NNN_PLUG='p:preview-tui;n:nuke;i:imgview;f:finder;a:autojump;u:getplugs;k:kdeconnect'
fi

# ─── DMENU / CM_LAUNCHER ────────────────────────────────────────
export CM_LAUNCHER=dmenu
export DMENU_OPTIONS="-i -l 10 -nb #1e1e2e -nf #cdd6f4 -sb #1e1e2e -sf #89b4fa"

# ─── VIMSPELL ────────────────────────────────────────────────────
[[ -d ~/.vim/spell ]] && export VIMSPELL=(~/.vim/spell/*.add(N))

# ─── ALIASES ────────────────────────────────────────────────────
[[ -f ~/.zsh_aliases ]] && source ~/.zsh_aliases
