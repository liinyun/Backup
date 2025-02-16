# this config is to load the blesh, but not attach to shell
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

# my alias
alias easyconnect="~/codes/shell_scripts/easyconnect.sh"
alias disablekvm="sudo ~/codes/shell_scripts/virtualbox.sh"
# alias newterm="alacritty --working-directory "$(pwd)" &"
# alias idea="/opt/idea-IU-243.22562.145/bin/idea"

newterm(){
  alacritty --working-directory "$(pwd)" &
}


# this is the shortcoming of powerline.
# it will not work properly in tmux, so I write this conditional statement to check current evnironment
# if the environment is tmux, it will close powerline 
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

# actually, this config is useless, because the only reason I use this config is to open directory with nvim
# now, I just need to run nvim in the folder
# nvimcd() {
#   if [ -d "$1" ]; then
#     TO_PATH=$1 nvim --cmd 'cd $TO_PATH' "${@:2}"
#   else
#     nvim "$@"
#   fi
# }
# alias nvim='nvimcd'


# direnv
eval "$(direnv hook bash)"


# fnm
FNM_PATH="/home/linya/.local/share/fnm"
if [ -d "$FNM_PATH" ]; then
  export PATH="$FNM_PATH:$PATH"
  eval "`fnm env`"
fi



# this will attach blesh to the shell
# source ~/.local/share/blesh/ble.sh
[[ ! ${BLE_VERSION-} ]] || ble-attach




# lingo config
export LINGO_20_HOME="/home/linya/applications/lingo"

export PATH="/home/linya/applications/lingo:$PATH"
