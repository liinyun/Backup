#!/usr/bin/env bash
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
export PATH="$PATH:/home/linya/Android/Sdk/cmdline-tools/latest/bin"
export PATH="$PATH:/home/linya/applications/riscv/bin"
export PATH="$PATH:/home/linya/applications/riscv_qemu/bin"
export PATH="$PATH:/home/linya/applications/lsp/lua-language-server/bin"
export PATH="$PATH:/home/linya/applications/lsp"
export PATH="$PATH:/home/linya/applications/sdks/garmin/share"
export PATH="$PATH:/home/linya/applications/sdks/garmin/bin"
# this is to fix libjpeg.so.8 unfind problem
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/home/linya/applications/sdks/garmin/lib/jpeg-8d/.libs
export PATH="$PATH:/home/linya/codes/shell_scripts/bin"
# export PATH="$PATH:/home/linya/codes/github/zig/build/stage3/bin"
# export PATH="$PATH:/home/linya/pyproject.toml"




export ANDROID_HOME=/home/linyun/Android/Sdk
export ANDROID_SDK_ROOT=/home/linyun/Android/Sdk
# export ANDROID_HOME=/home/linyun/Android/Sdk
export HISTSIZE=100000

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

# my alias
alias easyconnect="~/codes/shell_scripts/easyconnect.sh"
alias disablekvm="sudo ~/codes/shell_scripts/virtualbox.sh"
alias gt="source ~/codes/shell_scripts/jump_dir.sh"
# alias idea="/opt/idea-IU-243.22562.145/bin/idea"
alias rm='trash-put'


# it will not work properly in tmux, so I write this conditional statement to check current evnironment
# but I don't find it has any problem, so I open it again 
# if [[ -z "$TMUX" && -z "$STY" ]]; then
# source ~/codes/github/pureline/pureline ~/codes/github/pureline/configs/powerline_full_8col.conf
source ~/codes/shell_scripts/ps1/line
    # source ~/codes/github/pureline/pureline 
# fi



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


# direnv
eval "$(direnv hook bash)"
#

# fnm
FNM_PATH="/home/linya/.local/share/fnm"
if [ -d "$FNM_PATH" ]; then
  export PATH="$FNM_PATH:$PATH"
  eval "`fnm env`"
fi


# lingo config
export LINGO_20_HOME="/home/linya/applications/lingo"

export PATH="/home/linya/applications/lingo:$PATH"
. "$HOME/.cargo/env"



# this will attach blesh to the shell
# source ~/.local/share/blesh/ble.sh
[[ ! ${BLE_VERSION-} ]] || ble-attach



# fzf
eval "$(fzf --bash)"



#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"



