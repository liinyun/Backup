# .bashrc
[[ $- == *i* ]] && source /home/linya/codes/github/ble.sh/out/ble.sh --noattach
# Source global definitions
if [ -f /etc/bashrc ]; then
  . /etc/bashrc
fi

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]; then
  PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH


# imput method
export XMODIFIERS=@im=fcitx
export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export INPUT_METHOD=fcitx
export CLUTTER_IM_MODULE=fcitx

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
if [ -d ~/.bashrc.d ]; then
  for rc in ~/.bashrc.d/*; do
    if [ -f "$rc" ]; then
      . "$rc"
    fi
  done
fi
unset rc

export https_proxy=http://127.0.0.1:7897 http_proxy=http://127.0.0.1:7897 all_proxy=socks5://127.0.0.1:7897

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/linya/miniconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/linya/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/home/linya/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/linya/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<


alias easyconnect="~/codes/shell_scripts/easyconnect.sh"


# 这个是终端美化的脚本
if [[ -z "$TMUX" && -z "$STY" ]]; then
    source ~/codes/github/pureline/pureline ~/codes/github/pureline/configs/powerline_full_8col.conf
fi

. "$HOME/.cargo/env"

[[ ! ${BLE_VERSION-} ]] || ble-attach

# yazi
function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}