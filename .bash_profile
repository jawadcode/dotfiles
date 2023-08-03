#
# ~/.bash_profile
#

export MOZ_ENABLE_WAYLAND=1

# Added by Toolbox App
export PATH="$PATH:/home/jawad/.local/share/JetBrains/Toolbox/scripts"

export SDL_VIDEODRIVER=wayland
export GDK_BACKEND=wayland

export FZF_DEFAULT_COMMAND="fd -L"
export PATH=$PATH:/home/jawad/.config/emacs/bin:/home/jawad/.ghcup/bin:/home/jawad/go/bin:/home/jawad/.local/bin
[ -f "/home/jawad/.ghcup/env" ] && source "/home/jawad/.ghcup/env" # ghcup-env
. "$HOME/.cargo/env"

export GCM_CREDENTIAL_STORE="secretservice"
export EDITOR="helix"

export CC=clang
export CXX=clang++
export CC_LD=mold

export GTK_THEME=Yaru-blue-dark

[[ -f ~/.bashrc ]] && . ~/.bashrc
