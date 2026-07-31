#!/usr/bin/env bash
# this config is to load the blesh, but not attach to shell
[[ $- == *i* ]] && source /home/linya/.local/share/blesh/ble.sh --noattach
# .bashrc
# Source global definitions
if [ -f /etc/bashrc ]; then
  . /etc/bashrc
fi
# User specific environment
if ! [[ "$PATH" =~ $HOME/.local/bin:$HOME/bin: ]]; then
  PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi

bind '\C-p:unix-filename-rubout'

# export CHEZSCHEMELIBDIRS="/home/linya/.local/share/chez-lib/chez-docs"
export GEMINI_API_KEY="AIzaSyAjUka-KZeTVvNW4HRohtZzDyFbYk25gi4"
export STARSHIP_CONFIG=/home/linya/.config/starship/starship.toml
export PATH="$HOME/.luarocks/bin:$PATH"
export PATH="$PATH:/home/linya/.julia/bin"
export PATH="$PATH:/home/linya/codes/shell_scripts/bin"
# export PATH="$PATH:/home/linya/codes/github/tdf/target/release"
export PATH="$PATH:/home/linya/codes/github/fancy-cat/zig-out/bin"
export PATH="$PATH:/home/linya/opt/maven-mvnd-1.0.2-linux-amd64/bin"
export PATH="$PATH:/home/linya/Android/Sdk/cmdline-tools/latest/bin"
export PATH="$PATH:/home/linya/opt/riscv/bin"
export PATH="$PATH:/home/linya/opt/riscv_qemu/bin"
# export PATH="$PATH:/home/linya/opt/lsp/lua-language-server/bin"
# this is for otehr lsp like marksman
# export PATH="$PATH:/home/linya/opt/lsp"
export  PATH="$PATH:/home/linya/opt/lsp/postgresql_ls"
# 
# export PATH="$PATH:/home/linya/.dotnet/tools"
export PATH="$PATH:/home/linya/opt/kindle/kindlegen"
export PATH="$PATH:/home/linya/opt/fvm"
export PATH="$PATH:/home/linya/opt/blender-4.5.5-linux-x64"
# export PATH="$PATH:/home/linya/codes/github/zig/build/stage3/bin"

######################################################## garmin sdk config #############################################
# export PATH="$PATH:/home/linya/opt/sdks/garmin/share"
# export PATH="$PATH:/home/linya/opt/sdks/garmin/bin"
# export PATH="$PATH: /home/linya/opt/sdkmanager/bin"
# export PATH="$PATH:/home/linya/opt/sdkmanager/share"
# # this is to fix libjpeg.so.8 unfind problem
# export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/home/linya/opt/sdks/garmin/lib/jpeg-8d/.libs

# GARMIN_SDK_PATH="$(<"$HOME/.Garmin/ConnectIQ/current-sdk.cfg")"
# GARMIN_SDK_PATH="${GARMIN_SDK_PATH#"${GARMIN_SDK_PATH%%[![:space:]]*}"}" # Trim leading whitespace
# GARMIN_SDK_PATH="${GARMIN_SDK_PATH%"${GARMIN_SDK_PATH##*[![:space:]]}"}" # Trim trailing whitespace
# GARMIN_SDK_PATH="${GARMIN_SDK_PATH/\~/$HOME}" # Expand tilde to $HOME
# export PATH="$PATH:${GARMIN_SDK_PATH}"
########################################################################################################################


export ANDROID_HOME=/home/linya/Android/Sdk
export ANDROID_NDK_ROOT=/home/linya/Android/Sdk/ndk/28.2.13676358
export HISTSIZE=100000

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=
export PAGER=cat


export VCPKG_ROOT=/home/linya/.local/share/vcpkg
export PATH=$VCPKG_ROOT:$PATH


export HELIX_RUNTIME=/home/linya/codes/github/helix/runtime

# User specific aliases and functions
if [ -d ~/.bashrc.d ]; then
  for rc in ~/.bashrc.d/*; do
    if [ -f "$rc" ]; then
      # shellcheck disable=SC1090
      . "$rc"
    fi
  done
fi
unset rc

export https_proxy=http://127.0.0.1:7897 http_proxy=http://127.0.0.1:7897 all_proxy=socks5://127.0.0.1:7897
# export NVIM_APPNAME="fenvim"
export NVIM_APPNAME="nvim"

# my alias
alias julia='julia --project=@.'
alias easyconnect="~/codes/shell_scripts/easyconnect.sh"
alias disablekvm="sudo ~/codes/shell_scripts/virtualbox.sh"
alias gt="source ~/codes/shell_scripts/jump_dir.sh"
# alias idea="/opt/idea-IU-243.22562.145/bin/idea"
# alias rm='trash-put'
alias code='code --ozone-platform=wayland'
# alias androidsdk="/home/linya/Android/Sdk/cmdline-tools/latest/bin/sdkmanager"


# it will not work properly in tmux, so I write this conditional statement to check current evnironment
# but I don't find it has any problem, so I open it again 
# if [[ -z "$TMUX" && -z "$STY" ]]; then
# source ~/codes/github/pureline/pureline ~/codes/github/pureline/configs/powerline_full_8col.conf
source /home/linya/codes/shell_scripts/ps1/line
    # source ~/codes/github/pureline/pureline 
# fi



# yazi
function y() {
  local tmp
	tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd" || exit
	fi
	rm -f -- "$tmp"
}


# alias scp=~/.ssh/scp.sh
# alias ssh=~/.ssh/ssh.sh


# direnv
eval "$(direnv hook bash)"
#

# ocaml
eval $(opam env)

# lingo config
export LINGO_20_HOME="/home/linya/opt/lingo"

export PATH="/home/linya/opt/lingo:$PATH"
. "$HOME/.cargo/env"


# eval "$(starship init bash)"

# this will attach blesh to the shell
# source ~/.local/share/blesh/ble.sh
[[ ! ${BLE_VERSION-} ]] || ble-attach



# fzf
eval "$(fzf --bash)"



#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"


eval "$(mise activate bash)"



