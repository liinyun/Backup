# 这里是加载 blesh 但是不激活 blesh
[[ $- == *i* ]] && source ~/.local/share/blesh/ble.sh --noattach
# .bashrc
# Source global definitions
if [ -f /etc/bashrc ]; then
  . /etc/bashrc
fi

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]; then
  PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi

export PATH="$PATH:/home/linya/codes/github/tdf/target/release"
export PATH="$PATH:/home/linya/codes/github/fancy-cat/zig-out/bin"
export PATH="$PATH:/home/linya/applications/maven-mvnd-1.0.2-linux-amd64/bin"
# export PATH="$PATH:/home/linya/codes/github/zig/build/stage3/bin"
# export PATH="$PATH:/home/linya/pyproject.toml"


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

# 一些自定义的命令
alias easyconnect="~/codes/shell_scripts/easyconnect.sh"
# alias idea="/opt/idea-IU-243.22562.145/bin/idea"


# 这个是终端美化的脚本
# 我添加了一个判断，如果使用的是 tmux 就不开启美化了
if [[ -z "$TMUX" && -z "$STY" ]]; then
    source ~/codes/github/pureline/pureline ~/codes/github/pureline/configs/powerline_full_8col.conf
fi

. "$HOME/.cargo/env"


# yazi
function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}


alias scp=~/.ssh/scp.sh
alias ssh=~/.ssh/ssh.sh

# 为什么我这里选择创建一个函数然后使用别名的方式
# 这个是可以 nvim folder 直接打开一个文件夹
# 为了如果直接让这个函数的名字变成 nvim 那么别的程序如果要使用nvim 的时候可能就会使用这个函数，可能会造成错误
# 这个方案依旧是最好的方案，因为可以传递所有的参数
nvimcd() {
  if [ -d "$1" ]; then
    TO_PATH=$1 nvim --cmd 'cd $TO_PATH' "${@:2}"
  else
    nvim "$@"
  fi
}
alias nvim='nvimcd'
# direnv
eval "$(direnv hook bash)"


# fnm
FNM_PATH="/home/linya/.local/share/fnm"
if [ -d "$FNM_PATH" ]; then
  export PATH="$FNM_PATH:$PATH"
  eval "`fnm env`"
fi



# 这里才是激活，就是防止执行一些脚本的时候也把 blesh 也执行了，blesh 只能在交互式的shell 中执行
# source ~/.local/share/blesh/ble.sh
[[ ! ${BLE_VERSION-} ]] || ble-attach



