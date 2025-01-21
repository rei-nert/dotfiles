# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
*i*) ;;
*) return ;;
esac

# ---------------------- local utility functions ---------------------

_have() { type "$1" &>/dev/null; }
_source_if() { [[ -r "$1" ]] && source "$1"; }

# Enviroment variables
export HRULEWIDTH=73
export VISUAL=vi
export EDITOR_PREFIX=vi
export PICTURES="$HOME/Pictures"
export MUSIC="$HOME/Music"
export HELP_BROWSER=lynx
export DESKTOP="$HOME/Desktop"
export DOCUMENTS="$HOME/Documents"
export DOWNLOADS="$HOME/Downloads"
export VIDEOS="$HOME/Videos"
export USER="${USER:-$(whoami)}"
export GITUSER="$USER"
export GOPRIVATE="github.com/$GITUSER/*,gitlab.com/$GITUSER/*"
export GOPATH="$HOME/.local/share/go"
export GOBIN="$HOME/.local/bin"
export GOPROXY=direct
export CGO_ENABLED=0
export PYTHONDONTWRITEBYTECODE=2
export LC_COLLATE=C
export GTK_IM_MODULE=xim
export COMMON_FLAGS="-O2 -pipe -march=znver2"
export CFLAGS="${COMMON_FLAGS}"
export CXXFLAGS="${COMMON_FLAGS}"
export MAKEOPTS="-j6 -l6"
export ELECTRON_OZONE_PLATFORM_HINT="wayland"

if [[ -x /usr/bin/nvim ]]; then
	export EDITOR=nvim
elif [[ -x /usr/bin/vim ]]; then
	export EDITOR=vim
else
	export EDITOR=vi
fi

#GTK
export GDK_BACKEND=wayland

#Qt (should use wayland by default)
export QT_WAYLAND_DISABLE_WINDOWDECORATION=1

#Java
export _JAVA_AWT_WM_NONREPARENTING=1

### Theming

export QT_QPA_PLATFORMTHEME="qt5ct"

#gsettings set org.gnome.desktop.interface cursor-theme capitaine-cursors
#gsettings set org.gnome.desktop.interface icon-theme la-capitaine-icon-theme
#gsettings set org.gnome.desktop.interface gtk-theme Adwaita-dark
gsettings set org.gnome.desktop.interface color-scheme prefer-dark

# pager
if [[ -x /usr/bin/lesspipe ]]; then
	export LESSOPEN="| /usr/bin/lesspipe %s"
	export LESSCLOSE="/usr/bin/lesspipe %s %s"
fi

# Firefox
if [ "$XDG_SESSION_TYPE" == "wayland" ]; then
	export MOZ_ENABLE_WAYLAND=1
fi

export LESS_TERMCAP_mb=$(printf "\033[35m") # magenta
export LESS_TERMCAP_md=$(printf "\033[33m") # yellow
export LESS_TERMCAP_me=""                   # "0m"
export LESS_TERMCAP_se=""                   # "0m"
export LESS_TERMCAP_so=$(printf "\033[34m") # blue
export LESS_TERMCAP_ue=""                   # "0m"
export LESS_TERMCAP_us=$(printf "\033[4m")  # underline

[[ -d /.vim/spell ]] && export VIMSPELL=("$HOME/.vim/spell/*.add")

export CDPATH=".:/media/$USER:$HOME"

# ----------------------------- dircolors ----------------------------
if _have dircolors; then
	if [[ -r "$HOME/.dircolors" ]]; then
		eval "$(dircolors -b "$HOME/.dircolors")"
	else
		eval "$(dircolors -b)"
	fi
fi

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it

export HISTCONTROL=ignoreboth
export HISTSIZE=5000
export HISTFILESIZE=10000
# ------------------------ bash shell options ------------------------
shopt -s histappend
shopt -s expand_aliases
shopt -s globstar
shopt -s dotglob
shopt -s extglob
shopt -s checkwinsize # enables $COLUMNS and $ROWS
shopt -s autocd       # Enable autocd into directories

stty -ixon #Disable C-s and C-q

set -o vi

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
	debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
xterm-color | *-256color) color_prompt=yes ;;
esac

# Set doas completition
if [[ -x /usr/sbin/doas ]]; then
	complete -cf doas
fi
complete -cf sudo

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
	if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
		# We have color support; assume it's compliant with Ecma-48
		# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
		# a case would tend to support setf rather than setaf.)
		color_prompt=yes
	else
		color_prompt=
	fi
fi

if [ "$color_prompt" = yes ]; then
	PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
	PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm* | rxvt*)
	PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
	;;
*) ;;
esac

# enable color support of ls and also add handy aliases

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# ------------------------------- path -------------------------------

pathappend() {
	declare arg
	for arg in "$@"; do
		test -d "${arg}" || continue
		PATH=${PATH//:${arg}:/:}
		PATH=${PATH/#${arg}:/}
		PATH=${PATH/%:${arg}/}
		export PATH="${PATH:+"${PATH}:"}${arg}"
	done
}

pathprepend() {
	for ARG in "$@"; do
		test -d "${ARG}" || continue
		PATH=${PATH//:${ARG}:/:}
		PATH=${PATH/#${ARG}:/}
		PATH=${PATH/%:${ARG}/}
		export PATH="${ARG}${PATH:+":${PATH}"}"
	done
}

# override as needed in .bashrc_{personal,private,work}
# several utilities depend on SCRIPTS being in a github repo
export SCRIPTS=~/.local/bin/scripts
mkdir -p "$SCRIPTS" &>/dev/null

# remember last arg will be first in path
pathprepend \
	~/.local/share/flatpak/exports/bin \
	/var/lib/flatpak/exports/bin \
	/usr/local/go/bin \
	~/.local/share/applications \
	~/.local/bin \
	"$SCRIPTS"

pathappend \
	/usr/local/opt/coreutils/libexec/gnubin \
	/mingw64/bin \
	/usr/local/bin \
	/usr/local/sbin \
	/usr/local/games \
	/usr/games \
	/usr/sbin \
	/usr/bin \
	/snap/bin \
	/sbin \
	/bin

# some aliases
if [ -f "$HOME/.bash_aliases" ]; then
	. "$HOME/.bash_aliases"
fi

# --------------------------- smart prompt ---------------------------
PROMPT_LONG=20
PROMPT_MAX=95
PROMPT_AT=@

__ps1() {
	local P='$' dir="${PWD##*/}" B countme short long double \
		r='\[\e[31m\]' g='\[\e[30m\]' h='\[\e[34m\]' \
		u='\[\e[33m\]' p='\[\e[34m\]' w='\[\e[35m\]' \
		b='\[\e[36m\]' x='\[\e[0m\]'

	[[ $EUID == 0 ]] && P='#' && u=$r && p=$u # root
	[[ $PWD = / ]] && dir=/
	[[ $PWD = "$HOME" ]] && dir='~'

	B=$(git branch --show-current 2>/dev/null)
	[[ $dir = "$B" ]] && B=.
	countme="$USER$PROMPT_AT$(hostname):$dir($B)\$ "

	[[ $B == master || $B == main ]] && b="$r"
	[[ -n "$B" ]] && B="$g($b$B$g)"

	short="$u\u$g$PROMPT_AT$h\h$g:$w$dir$B$p$P$x "
	long="$g╔ $u\u$g$PROMPT_AT$h\h$g:$w$dir$B\n$g╚ $p$P$x "
	double="$g╔ $u\u$g$PROMPT_AT$h\h$g:$w$dir\n$g║ $B\n$g╚ $p$P$x "

	if ((${#countme} > PROMPT_MAX)); then
		PS1="$double"
	elif ((${#countme} > PROMPT_LONG)); then
		PS1="$long"
	else
		PS1="$short"
	fi
}

PROMPT_COMMAND="__ps1"

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

# ASDF for software manager on Arch Linux
if [[ -x /opt/asdf-vm/bin/asdf ]]; then
	. /opt/asdf-vm/asdf.sh
fi

# ASDF for software manager using Git
 . $HOME/.asdf/asdf.sh
. $HOME/.asdf/completions/asdf.bash
#

# NNN config
if [[ -x /usr/bin/nnn ]]; then
	export NNN_OPTS="deH"           # d for details, e to open files in $VISUAL H for hidden files
	export LC_COLLATE="C"           # hidden files on top
	export NNN_FIFO="/tmp/nnn.fifo" # temporary buffer for the previews
	export NNN_FCOLORS="AAAAE631BBBBCCCCDDDD9999"
	export NNN_PLUG='p:preview-tui;n:nuke;i:imgview;f:finder;a:autojump;u:getplugs;k:kdeconnect'
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
	if [ -f /usr/share/bash-completion/bash_completion ]; then
		. /usr/share/bash-completion/bash_completion
	elif [ -f /etc/bash_completion ]; then
		. /etc/bash_completion
	fi
fi
