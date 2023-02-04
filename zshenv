# XDG Base Dirs
export XDG_CONFIG_HOME=$HOME/.config
export XDG_CACHE_HOME=$HOME/.cache
export XDG_DATA_HOME=$HOME/.local/share
export XDG_STATE_HOME=$HOME/.local/share
export XDG_DESKTOP_DIR=$HOME/Desktop
export XDG_DOWNLOAD_DIR=$HOME/Downloads
export XDG_TEMPLATES_DIR=$HOME/Templates
export XDG_PUBLICSHARE_DIR=$HOME/Public
export XDG_DOCUMENTS_DIR=$HOME/Documents
export XDG_MUSIC_DIR=$HOME/Music
export XDG_PICTURES_DIR=$HOME/Pictures
export XDG_VIDEOS_DIR=$HOME/Videos
# export XDG_CURRENT_DESKTOP=wayfire

# ZDOTDIR variable
export ZDOTDIR=$XDG_CONFIG_HOME/shell/zsh

# Default apps
export EDITOR=nvim
export TERMINAL=kitty
export BROWSER=firefox-beta
export READER=zathura

# Qt
export QT_QPA_PLATFORM=wayland

# Qtcreator
export QT_ASSUME_STDERR_HAS_CONSOLE=1

# fcitx5
export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS=@im=fcitx
export SDL_IM_MODULE=fcitx
export GLFW_IM_MODULE=ibus

# pkglist store
export PKGLIST_DIR=$HOME/.dotfiles/pkglist

export WLR_DRM_DEVICES=/dev/dri/card0
export WLR_RENDER_DRM_DEVICE=/dev/dri/renderD128

# bat theme
export BAT_THEME="Catppuccin-mocha"

# LANGUAGE
# LANG=zh_CN.UTF-8
# LANGUAGE=zh_CN:en_US
