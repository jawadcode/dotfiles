# Jawad's Dotfiles

They change a lot.

## Setup Guide:

### Install arch:

Install arch using the [Installation guide](https://wiki.archlinux.org/title/Installation_guide) and then a bootloader
(I chose [GRUB](https://wiki.archlinux.org/title/GRUB)) and some kind of network manager (I chose the `networkmanager` package).

### Utilities:

* `base-devel` - A group of packages which provides useful tools for building C/C++ projects from source
* [Cmake](https://cmake.org) - A C/C++ build tool, which is often required for building programs from source
* [Fish](https://github.com/fish-shell/fish-shell) - A sane, user-friendly (and non POSIX-compliant) shell
* [Fd](https://github.com/sharkdp/fd) - A faster and easier alternative to GNU Find
* [Ripgrep](https://github.com/burntsushi/ripgrep) - A faster and better alternative to GNU Grep
* [Bat](https://github.com/sharkdp/bat) - An alternative to GNU Cat with syntax highlighting and a git gutter
* [Lsd](https://github.com/lsd-rs/lsd) - An alternative to GNU ls with colours, icons, tree-view etc
* [Helix](https://github.com/helix-editor/helix) - A TUI modal text editor based on Kakoune and Neovim, with built-in LSP support

```bash
paru -S base-devel \
        cmake      \
        git        \
        fish       \
        fd         \
        ripgrep    \
        bat        \
        lsd        \
        helix      \
```

Note that we aren't using chsh to change the login shell to fish,
rather we `exec fish` from within `.bashrc` to prevent issues with lazily written
POSIX shell or BASH scripts which don't contain a shebang.

```bash
# Dotfiles:
cp dotfiles/.profile ~/
cp dotfiles/.bashrc ~/
cp dotfiles/.bash_profile ~/
cp dotfiles/.gitconfig ~/

# Scripts:
cp dotfiles/paru-remove-orphaned.sh ~/
cp dotfiles/cargo_binaries_update.sh ~/
cp dotfiles/update_pip.py ~/
```

### Paru:

In order to install packages from the AUR (Arch User Repository) you need to install an AUR helper,
I chose [Paru](https://github.com/Morganamilo/paru) because of its colour support and package review functionality.

#### Installation:

```bash
git clone https://aur.archlinux.org/paru.git
cd paru
makepkg -si
```

### Development Environment:

#### Toolchains:

##### Rustup - toolchain manager for Rust:

https://rustup.rs contains instructions on how to install, or it can be installed using `paru`:

```bash
# This may conflict with `rust` however that is just a built-dependency of `paru` so it can be safely uninstalled
paru -S rustup
```

##### GHCup - manages different versions of GHC, Cabal, Stack and HLS:

https://haskell.org/ghcup contains instructions on how to install, or it can be installed using `paru`:

```bash
paru -S ghcup-hs-bin
```

#### Opam - source-based package manager for OCaml tooling and libraries:

https://ocaml.org/docs/get-up-and-running contains instructions on how to install,
including installing opam using `pacman`

### C/C++:

#### Clang:

I prefer `clang`/`clang++` as I'm pretty sure they produce better output in terms of warnings and errors,
and also because of my slightly-irrational anti-GNU bias (also manifested in my disgust of GNU extensions).

```bash
paru -S llvm  \
        clang \
        lldb  \
```

#### Mold:

I've elected to use mold as the default linker for all Rust and C/C++ projects as it is a faster,
highly-parallel alternative to GNU gold (which is the default and is included in GNU binutils).
The `CC_LD` environment variable is set to `mold` in `~/.bash_profile` for build systems to detect and use.

```bash
paru -S mold

# Sets up mold as the linker for cargo projects:
cp dotfiles/.cargo/config.toml ~/.cargo
```

#### Meson:

Meson is one of the easiest to use, yet most flexible and configurable meta-build systems I've come across.
It generates `ninja` build files under the hood for rapid compilation speeds.

```bash
paru -S meson
```

#### Conan:

Conan is a package manager for C/C++ projects, and has a fairly large repository,
as well as integrating with several build systems. Behind the scenes, it compiles and stores dependencies
you've installed in a local registry so that object files can be reused even across projects,
which saves a lot of time.

```bash
paru -S conan
```

### WM Setup:

* [Ly] - A lightweight TUI display/login manager
* Swaybg - Sets the desktop background
* Swaylock - A lock screen that will be used when the computer idles
* Swayidle - Idle management daemon which allows you to put the computer to sleep after a short while
* [Hyprland](https://github.com/hyprwm/Hyprland) - A feature-rich, customisable, dynamic-tiling Wayland WM
* [Pipewire](https://gitlab.freedesktop.org/pipewire/pipewire) - An API to deal with multi-media pipelines, particularly audio
* [Wireplumber](https://gitlab.freedesktop.org/pipewire/wireplumber) - A session manager for Pipewire
* XDG Desktop Portal - Desktop integration portals for sandboxed apps (e.g. flatpak apps)
* [Hyprshot](https://github.com/Gustash/Hyprshot) - A screenshot tool for Hyprland
* [Mako](https://github.com/emersion/mako) - A lightweight Wayland notification daemon
* [Eww](https://github.com/owenrumney/eww-bar) - A tool for writing customisable, styleable widgets, including status bars
* [NWG Drawer](https://github.com/nwg-piotr/nwg-drawer) - An application drawer for wlroots-based compositors, like Hyprland or Sway
* [Nautilus](https://gitlab.gnome.org/GNOME/nautilus) - GNOME Files (the best file browser)
* [Wezterm](https://github.com/wez/wezterm) - A GPU-accelerated terminal emulator and multiplexer
* Firefox - The best browser (with some configuration of course)
* [GNOME Disk Utility] - Lists available drives with metadata, allows formatting and partitioning
* Secret Service - A secure way of storing credentials, in this case git credentials

```bash
paru -S ly                             \
        swaybg                         \
        openmp                         \
        swaylock-effects               \
        swayidle                       \
        hyprland                       \
        pipewire                       \
        pipewire-alsa                  \
        pipewire-pulse                 \
        pipewire-jack                  \
        wireplumber                    \
        xdg-desktop-portal             \
        xdg-desktop-portal-wlr         \
        xdg-desktop-portal-gtk         \
        mako                           \
        hyprshot                       \
        socat                          \
        python                         \
        python-pip                     \
        python-psutil                  \
        eww-wayland                    \
        nwg-drawer-bin                 \
        yaru-gtk-theme                 \
        yaru-plus-git                  \
        nautilus                       \
        wezterm                        \
        firefox                        \
        gnome-disk-utility             \
        secret-service                 \
        noto-fonts                     \
        noto-fonts-cjk                 \
        noto-fonts-emoji               \
        noto-fonts-extra               \
        ttf-jetbrains-mono             \
        ttf-jetbrains-mono-nerd        \
        ttf-font-awesome

cp -r dotfiles/.config/* ~/.config

# The runtime dir contains tree-sitter grammars for syntax highlighting
ln -s /usr/lib/helix/runtime ~/.config/helix/runtime

# Git stuff:
systemctl --user enable secretserviced.service
systemctl --user start secretserviced.service

cd /usr/share/git/credential/libsecret/
sudo make

# GTK theme (this is done in `~/.config/gtk-3.0/settings.ini` and
# `~/.config/gtk-4.0/settings.ini` but this is just to be safe):
gsettings set org.gnome.desktop.interface gtk-theme "Yaru-blue-dark"
gsettings set org.

# WM stuff
sudo systemctl enable ly

systemctl --user enable pipewire.service
systemctl --user start pipewire.service

sudo systemctl start ly
```
## Hyprland NVidia config:

See [hyprland-nvidia.md](hyprland-nvidia.md)
