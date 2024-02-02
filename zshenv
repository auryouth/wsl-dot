# User Dirs
export XDG_CONFIG_HOME=$HOME/.config
export XDG_CACHE_HOME=$HOME/.cache
export XDG_DATA_HOME=$HOME/.local/share
export XDG_STATE_HOME=$HOME/.local/share

# ZDOTDIR variable
export ZDOTDIR=$XDG_CONFIG_HOME/shell/zsh

# pkglist store
export PKGLIST_DIR=$HOME/.dotfile/pkglist

# Default apps
export EDITOR=nvim
export TERMFM=yazi
export FETCH=fastfetch

if [ -d "$HOME/bin" ] ; then
    export PATH="$PATH:$HOME/bin"
fi

if [ -d "$HOME/.local/bin" ] ; then
    export PATH="$PATH:$HOME/.local/bin"
fi
