# nixos-config

My personal NixOS dotfiles and configuration.

## Structure

- `configuration.nix` — main NixOS system config
- `dotfiles/` — config files for apps (waybar, hypr, nvim, etc.)
- `minecraft/` — Fabulously Optimized mods and config
- `.zshrc` — zsh config

## Fresh Install

1. Clone the repo:
   `git clone git@github.com:KevinMeisdalen/nixos-config.git ~/nixos-config`

2. Edit configuration.nix and change the username and hostname:
   `nano ~/nixos-config/configuration.nix`

3. Copy configs:
   ```
   cp ~/nixos-config/configuration.nix /etc/nixos/
   cp -r ~/nixos-config/dotfiles/* ~/.config/
   cp ~/nixos-config/.zshrc ~/
   mkdir -p "/home/nix/.local/share/PrismLauncher/instances/Fabulously Optimized/"
   cp -r ~/nixos-config/minecraft "/home/nix/.local/share/PrismLauncher/instances/Fabulously Optimized/"
   ```

4. Rebuild:
   `sudo nixos-rebuild switch`


## Updating the system
1. Clone the repo:
   `git clone git@github.com:KevinMeisdalen/nixos-config.git ~/nixos-config`

2. Edit configuration.nix and remove/keep nvidia:
   `nano ~/nixos-config/configuration.nix`

3. Copy configs:
   ```
   cp ~/nixos-config/configuration.nix /etc/nixos/
   cp -r ~/nixos-config/dotfiles/* ~/.config/
   cp ~/nixos-config/.zshrc ~/
   ```

4. Rebuild:
   `sudo nixos-rebuild switch`


## Updating the Repo

Run these commands to sync any changes back to the repo:
```
   # system
cp /etc/nixos/configuration.nix ~/nixos-config/
cp ~/.zshrc ~/nixos-config/

# dotconfig dirs
cp -r ~/.config/alacritty  ~/nixos-config/dotconfig/
cp -r ~/.config/bat        ~/nixos-config/dotconfig/
cp -r ~/.config/btop       ~/nixos-config/dotconfig/
cp -r ~/.config/cava       ~/nixos-config/dotconfig/
cp -r ~/.config/dunst      ~/nixos-config/dotconfig/
cp -r ~/.config/eza        ~/nixos-config/dotconfig/
cp -r ~/.config/fastfetch  ~/nixos-config/dotconfig/
cp -r ~/.config/gtk-3.0    ~/nixos-config/dotconfig/
cp -r ~/.config/gtk-4.0    ~/nixos-config/dotconfig/
cp -r ~/.config/hypr       ~/nixos-config/dotconfig/
cp -r ~/.config/hyprshell  ~/nixos-config/dotconfig/
cp -r ~/.config/kitty      ~/nixos-config/dotconfig/
cp -r ~/.config/Kvantum    ~/nixos-config/dotconfig/
cp -r ~/.config/nvim       ~/nixos-config/dotconfig/
cp -r ~/.config/rofi       ~/nixos-config/dotconfig/
cp -r ~/.config/waybar     ~/nixos-config/dotconfig/
cp -r ~/.config/yazi       ~/nixos-config/dotconfig/
cp -r ~/.config/zathura    ~/nixos-config/dotconfig/

# dotconfig files
cp ~/.config/mimeapps.list ~/nixos-config/dotconfig/
cp ~/.config/starship.toml ~/nixos-config/dotconfig/

# git
cd ~/nixos-config && git add . && git commit -m "update" && git push
```
