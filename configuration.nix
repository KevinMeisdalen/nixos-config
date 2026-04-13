{ config, pkgs, ... }:
{
  imports = [
    ./hardware-configuration.nix
  ];
  # -----------------------
  # BOOTLOADER
  # -----------------------
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  # -----------------------
  # NETWORK
  # -----------------------
  networking.hostName = "meisdalen";
  networking.networkmanager.enable = true;
  # -----------------------
  # TIME / LOCALE
  # -----------------------
  time.timeZone = "Europe/Oslo";
  i18n.defaultLocale = "en_US.UTF-8";
  # -----------------------
  # NIX FEATURES
  # -----------------------
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  # -----------------------
  # NVIDIA
  # -----------------------
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia = {
    modesetting.enable = true;
    open = false;
    nvidiaSettings = true;
  };
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
  };  
  # -----------------------
  # DISPLAY / LOGIN
  # -----------------------
  services.xserver.enable = true;
  services.displayManager.sddm = {
    enable = true;
  };
  # -----------------------
  # HYPRLAND
  # -----------------------
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };
  # -----------------------
  # PORTALS (WAYLAND FIX)
  # -----------------------
  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-hyprland
      xdg-desktop-portal-gtk
    ];
  };
  # -----------------------
  # AUDIO (PIPEWIRE)
  # -----------------------
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };
  services.pulseaudio.enable = false;
  programs.noisetorch.enable = true;
  # -----------------------
  # INPUT
  # -----------------------
  services.libinput.enable = true;

  fonts.packages = with pkgs; [
  noto-fonts
  noto-fonts-color-emoji
  nerd-fonts.jetbrains-mono
  icomoon-feather
];
  services.mullvad-vpn.enable = true;
  services.gnome.sushi.enable = true;
  # -----------------------
  # PACKAGES
  # -----------------------
  environment.systemPackages = with pkgs; [
    bibata-cursors
    # terminals
    alacritty
    kitty
    # wayland tools
    waybar
    rofi
    dunst
    hyprpaper
    hypridle
    hyprlock
    hyprshot
    hyprshell
    hyprpicker
    imv
    # file/tools
    nautilus
    sushi
    xfce.tumbler
    webp-pixbuf-loader
    gst_all_1.gst-plugins-base
    gst_all_1.gst-plugins-good
    gst_all_1.gst-plugins-bad
    kdePackages.dolphin
    yazi
    zathura
    easyeffects
    playerctl
    # cli
    git
    gh
    curl
    wget
    jq
    tree
    ripgrep
    fd
    fzf
    tmux
    eza
    bat
    btop
    fastfetch
    # dev
    go
    rustc
    cargo
    python3
    nodejs
    pnpm
    bun
    deno
    jdk17
    kotlin
    maven
    gradle
    dotnet-sdk
    php
    ruby
    elixir
    scala
    # devops
    docker-compose
    kubectl
    kubernetes-helm
    terraform
    ansible
    tailscale
    age
    sops
    # apps
    brave
    firefox
    discord
    spotify
    bitwarden-desktop
    obsidian
    nextcloud-client
    mullvad-vpn
  ];
  # -----------------------
  # ENVIRONMENT VARIABLES
  # -----------------------
  environment.variables = {
    XCURSOR_THEME = "Bibata-Modern-Classic";
    XCURSOR_SIZE = "24";
  };
  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    LIBVA_DRIVER_NAME = "nvidia";
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    GBM_BACKEND = "nvidia-drm";
    NVD_BACKEND = "direct";
    WLR_NO_HARDWARE_CURSORS = "1";
    GST_PLUGIN_SYSTEM_PATH_1_0 = "${pkgs.gst_all_1.gst-plugins-base}/lib/gstreamer-1.0:${pkgs.gst_all_1.gst-plugins-good}/lib/gstreamer-1.0:${pkgs.gst_all_1.gst-plugins-bad}/lib/gstreamer-1.0";
  };
  # -----------------------
  # SERVICES
  # -----------------------
  services.printing.enable = true;
  services.tailscale.enable = true;
  virtualisation.docker.enable = true;
  # -----------------------
  # USER
  # -----------------------
  users.users.nix = {
    isNormalUser = true;
    extraGroups = [ "networkmanager" "wheel" "docker" ];
  };
  # -----------------------
  # UNFREE PACKAGES
  # -----------------------
  nixpkgs.config.allowUnfree = true;
  system.stateVersion = "25.11";
}
