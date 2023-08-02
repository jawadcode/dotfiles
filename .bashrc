#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '

alias credential-manager="git-credential-manager"

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

exec fish
