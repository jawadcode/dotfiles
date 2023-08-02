alias dotup="/usr/bin/git --git-dir=$HOME/dotfiles --work-tree=$HOME"

function psearch
    paru --color always -Ss $argv | less -r
end

function mdtopdf
    pandoc -V geometry:margin=1in -V fontsize=12pt $argv
end

if status is-interactive
    # opam configuration
    source /home/jawad/.opam/opam-init/init.fish > /dev/null 2> /dev/null; or true

    fish_vi_key_bindings

    function fish_greeting
        cat /home/jawad/fish_greeting.txt
    end

    source (/usr/bin/starship init fish --print-full-init | psub)

    alias grep="grep --color"
    abbr opamclean "opam clean -c --logs -r -s --unused-repositories -y"
    abbr ghcupgc "ghcup gc -o -p -s -c -t"

    abbr tree "lsd --tree"
end

