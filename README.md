# nixos-config

My personal NixOS dotfiles and configuration.

## Structure

- `configuration.nix` — main NixOS system config
- `dotfiles/` — config files for apps (waybar, hypr, nvim, etc.)
- `minecraft/` — Fabulously Optimized mods and config
- `.zshrc` — zsh config

## Fresh Install

1. Clone the repo:
   git clone git@github.com:KevinMeisdalen/nixos-config.git ~/nixos-config

2. Edit configuration.nix and change the username and hostname:
   nano ~/nixos-config/configuration.nix

3. Copy configs:
   cp ~/nixos-config/configuration.nix /etc/nixos/
   cp -r ~/nixos-config/dotfiles/* ~/.config/
   cp ~/nixos-config/.zshrc ~/
   mkdir -p "/home/nix/.local/share/PrismLauncher/instances/Fabulously Optimized/"
   cp -r ~/nixos-config/minecraft "/home/nix/.local/share/PrismLauncher/instances/Fabulously Optimized/"

4. Rebuild:
   sudo nixos-rebuild switch

## Updating the Repo

Run these commands to sync any changes back to the repo:

   cp /etc/nixos/configuration.nix ~/nixos-config/
   cp -r ~/.config/hypr ~/nixos-config/dotfiles/
   cp -r ~/.config/waybar ~/nixos-config/dotfiles/
   cp -r ~/.config/nvim ~/nixos-config/dotfiles/
   cp ~/.zshrc ~/nixos-config/
   cd ~/nixos-config && git add . && git commit -m "update" && git push
