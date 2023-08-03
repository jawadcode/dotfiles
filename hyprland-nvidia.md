# Hyperland NVidia Config:

This set of instructions is intended for and was tested on an NVidia Optimus laptop.
For an NVidia desktop, follow the instructions in the Hyprland wiki: [https://wiki.hyprland.org/Nvidia].

```bash
paru -Rns hyprland

paru -S hyprland-nvidia \
        linux-headers   \
        nvidia-dkms
```

Add `nvidia_drm.modeset=1` to the end of `GRUB_CMDLINE_LINUX_DEFAULT=` in `/etc/default/grub`.

Run `grub-mkconfig -o /boot/grub/grub.cfg`.

Add `nvidia nvidia_modeset nvidia_uvm nvidia_drm` to `MODULES` in `/etc/mkinitcpio.conf`.

Run `mkinitcpio --config /etc/mkinitcpio.conf --generate /boot/initramfs-custom.img`.

Add `options nvidia-drm modeset=1` to `/etc/modprobe.d/nvidia.conf`.

Add
```
env = LIBVA_DRIVER_NAME,nvidia
env = XDG_SESSION_TYPE,wayland
env = __GLX_VENDOR_LIBRARY_NAME,nvidia
env = WLR_NO_HARDWARE_CURSORS,1
env = __NV_PRIME_RENDER_OFFLOAD,1
env = __VK_LAYER_NV_optimus,NVIDIA_only
```
to `~/.config/hypr/hyprland.conf`

```bash
paru -S qt5-wayland         \
        qt5ct               \
        libva               \
        libva-nvidia-driver \
```

Note: you may want to add `enable_wayland = true` to your wezterm config,
I discovered a bug where the window is completely transprent and this fixed it.
