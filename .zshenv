# Core paths
export SCRIPTS=~/.local/bin/scripts
[[ ! -x $SCRIPTS ]] && mkdir -p $SCRIPTS

# XDG / session
export XDG_SESSION_TYPE=x11
export MOZ_ENABLE_WAYLAND=1  # only if wayland

# Editor & visual
export EDITOR=nvim
export VISUAL=nvim
export EDITOR_PREFIX=nvim
export HELP_BROWSER=lynx

# Directories
export PICTURES="$HOME/Pictures"
export MUSIC="$HOME/Music"
export DESKTOP="$HOME/Desktop"
export DOCUMENTS="$HOME/Documents"
export DOWNLOADS="$HOME/Downloads"
export VIDEOS="$HOME/Videos"

# CDPATH
export CDPATH=".:/media/$USER:$HOME"

# Git / Go
export GITUSER="$USER"
export GOPRIVATE="github.com/$GITUSER/*,gitlab.com/$GITUSER/*"
export GOPATH="$HOME/.local/share/go"
export GOBIN="$HOME/.local/bin"
export GOPROXY=direct
export CGO_ENABLED=1

# Python / locale / misc
export PYTHONDONTWRITEBYTECODE=2
export LC_COLLATE=C
export GTK_IM_MODULE=xim
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'
export HRULEWIDTH=73

# Java AWT
export _JAVA_AWT_WM_NONREPARENTING=1

# OBSIDIAN (Hermes)
export OBSIDIAN_VAULT_PATH=/home/rei-nert/Nextcloud/Miscellaneous/Hermes/
