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













