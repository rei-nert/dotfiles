# Source .zshenv if not already
[[ -f ~/.zshenv ]] && source ~/.zshenv

# PATH manipulation 
path=(
  ~/.local/share/flatpak/exports/bin
  /var/lib/flatpak/exports/bin
  /usr/local/go/bin
  ~/.local/share/applications
  ~/.local/bin
  $SCRIPTS
  /usr/local/opt/coreutils/libexec/gnubin
  /mingw64/bin
  /usr/local/bin
  /usr/local/sbin
  /usr/local/games
  /usr/games
  /usr/sbin
  /usr/bin
  /snap/bin
  /sbin
  /bin
  $path
)
# Remove duplicates
typeset -U path

# Hermes Agent
export PATH="$HOME/.local/bin:$PATH"
