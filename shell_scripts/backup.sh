#!/bin/bash

# target path
CONFIG_PATH_TARGET="$HOME/codes/Backup/.config"
HOME_PATH_TARGET="$HOME/codes/Backup"


# scripts
SHELL_SCRIPTS="$HOME/codes/shell_scripts"
rsync -av --delete "$SHELL_SCRIPTS" "$HOME_PATH_TARGET"


BASH_SCRIPTS="$HOME/.bashrc"
rsync -av --delete "$BASH_SCRIPTS" "$HOME_PATH_TARGET"


TMUX_SCRIPTS="$HOME/.tmux.conf"
rsync -av --delete "$TMUX_SCRIPTS" "$HOME_PATH_TARGET"


# alacritty
ALACRITTY_PATH_SOURCE="$HOME/.config/alacritty"

rsync -av --delete "$ALACRITTY_PATH_SOURCE" "$CONFIG_PATH_TARGET"

# nvim
NVIM_PATH_SOURCE="$HOME/.config/nvim"
rsync -av --delete "$NVIM_PATH_SOURCE" "$CONFIG_PATH_TARGET"

# mpv
MPV_PATH_SOURCE="$HOME/.config/mpv"
rsync -av --delete "$MPV_PATH_SOURCE" "$CONFIG_PATH_TARGET"

# kitty
KITTY_PATH_SOURCE="$HOME/.config/kitty"
rsync -av --delete "$KITTY_PATH_SOURCE" "$CONFIG_PATH_TARGET"

# niri
NIRI_PATH_SOURCE="$HOME/.config/niri"
rsync -av --delete "$NIRI_PATH_SOURCE" "$CONFIG_PATH_TARGET"

# xsettingsd
XSETTINGSD_PATH_SOURCE="$HOME/.config/xsettingsd"
rsync -av --delete "$XSETTINGSD_PATH_SOURCE" "$CONFIG_PATH_TARGET"

# mpd
MPD_PATH_SOURCE="$HOME/.config/mpd"
rsync -av --delete "$MPD_PATH_SOURCE" "$CONFIG_PATH_TARGET"

# rmpc
RMPC_PATH_SOURCE="$HOME/.config/rmpc"
rsync -av --delete "$RMPC_PATH_SOURCE" "$CONFIG_PATH_TARGET"

# waybar
WAYBAR_PATH_SOURCE="$HOME/.config/waybar"
rsync -av --delete "$WAYBAR_PATH_SOURCE" "$CONFIG_PATH_TARGET"


# hypr
HYPR_PATH_SOURCE="$HOME/.config/hypr"
rsync -av --delete "$HYPR_PATH_SOURCE" "$CONFIG_PATH_TARGET"


# desktopfile
DESKTOP_PATH_SOURCE="$HOME/.local/share/applications"
rsync -av --delete "$DESKTOP_PATH_SOURCE" "$CONFIG_PATH_TARGET"










