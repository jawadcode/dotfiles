#! /usr/bin/env fish

function begin_section
    set_color --bold --italics brgreen
    echo "(* BEGIN: $argv *)"
    set_color normal
end

function end_section
    set_color --bold --italics brgreen
    printf "(* END: $argv *)\n\n"
    set_color normal
end

function update --description "Update all the shit that you don't even use"
    begin_section "Updating system packages"
    paru
    end_section "Updated system packages"

    begin_section "Updating rust"
    rustup update
    end_section "Updated rust"

    begin_section "Updating haskell"
    ghcup upgrade --inplace
    end_section "Updated haskell"

    begin_section "Updating ocaml"
    opam update
    opam upgrade
    end_section "Updated ocaml"

    if command -q elan
        begin_section "Updating lean"
        elan update
        end_section "Updated lean"
    end

    begin_section "Updating idris2"
    pack update-db
    pack update
    end_section "Updated idris2"

    begin_section "Updating neovim"
    nvim # Can't do `nvim +"Lazy sync"`
    end_section "Updated neovim"

    begin_section "Updating doom emacs"
    doom upgrade
    doom sync
    end_section "Updated doom emacs"
end

function clean --description "Clean up the crap left behind"
    begin_section "Cleaning orphaned packages"
    paru -Qtdq | paru -Rns -
    paru -Qqd  | paru -Rsu -
    end_section "Cleaned orphaned packages"

    begin_section "Cleaning package cache"
    paru -Scc
    end_section "Cleaned package cache"

    begin_section "Cleaning haskell"
    ghcup gc --ghc-old --profiling-libs --share-dir --hls-no-ghc --cache \
        --tmpdirs
    end_section "Cleaned haskell"

    begin_section "Cleaning ocaml"
    opam clean --all-switches --download-cache --logs --repo-cache \
        --switch-cleanup --unused-repositories
    end_section "Cleaned ocaml"

    begin_section "Cleaning idris2"
    pack gc
    end_section "Cleaned idris2"

    begin_section "Cleaning doom emacs"
    doom purge
    doom clean
    end_section "Cleaned doom emacs"
end

function run([string]$command) {
    switch ($command) {
        update { update }
        clean  { clean }
        * {
            echo "Usage: ./update.fish (update|clean)"
            exit 1
        }
    }
}

if ($argv[1] -eq "--wsl") {
} elseif ($argv[2] -eq "--wsl") {
} else {
}
