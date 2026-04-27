{ config, pkgs, lib, ... }:
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
  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = false;
    powerManagement.finegrained = false;
    open = false;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
  };
  # -----------------------
  # ZSH
  # -----------------------
  programs.zsh = {
    enable = true;
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;
    ohMyZsh = {
      enable = true;
      plugins = [
        "git"
        "sudo"
        "z"
        "colored-man-pages"
        "command-not-found"
      ];
      theme = "";
    };
  };
  programs.starship.enable = true;
  # -----------------------
  # DISPLAY / LOGIN
  # -----------------------
  services.xserver.enable = true;
  services.displayManager.sddm = {
    enable = true;
  };
  systemd.user.services.swayosd = {
    description = "SwayOSD server";
    wantedBy = [ "graphical-session.target" ];
    after = [ "graphical-session.target" ];
    partOf = [ "graphical-session.target" ];
    serviceConfig = {
      ExecStart = "${pkgs.swayosd}/bin/swayosd-server";
      Restart = "on-failure";
      RestartSec = "3s";
    };
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
  # -----------------------
  # FONTS
  # -----------------------
  fonts.packages = with pkgs; [
    noto-fonts
    jetbrains-mono
    noto-fonts-color-emoji
    nerd-fonts.jetbrains-mono
    icomoon-feather
  ];
  services.mullvad-vpn.enable = true;
  services.gnome.sushi.enable = true;
  # -----------------------
  # OBS STUDIO
  # -----------------------
  programs.obs-studio = {
    enable = true;
    package = pkgs.obs-studio.override {
      ffmpeg = pkgs.ffmpeg-full;
 #     cudaSupport = true;
    };
    plugins = with pkgs.obs-studio-plugins; [
      obs-pipewire-audio-capture
      obs-vkcapture
      wlrobs
    ];
  };
  # -----------------------
  # PACKAGES
  # -----------------------
  environment.systemPackages = with pkgs; [
    bibata-cursors
    # terminals
    alacritty
    kitty
    starship
    # wayland tools
    waybar
    rofi
    dunst
    libnotify
    hyprpaper
    hypridle
    hyprlock
    hyprshot
    pkgs.hyprshade
    hyprshell
    hyprpicker
    imv
    # file/tools
    nautilus
    sushi
    xfce.tumbler
    webp-pixbuf-loader
    swayosd
    gst_all_1.gst-plugins-base
    gst_all_1.gst-plugins-good
    gst_all_1.gst-plugins-bad
    kdePackages.dolphin
    yazi
    zathura
    easyeffects
    playerctl
    cliphist
    wl-clipboard
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
    ffmpeg-full
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
    firefox
    discord
    pkgs.vlc
    pkgs.obs-cmd
    (vscode-with-extensions.override {
      vscodeExtensions = with vscode-extensions; [
        # Formatting & Linting
        esbenp.prettier-vscode
        dbaeumer.vscode-eslint
        # Git
        eamodio.gitlens
        # Paths & HTML
        christian-kohler.path-intellisense
        formulahendry.auto-rename-tag
        # REST & Docker
        humao.rest-client
        ms-azuretools.vscode-docker
        # Tailwind
        bradlc.vscode-tailwindcss
        # Visual
        oderwat.indent-rainbow
        naumovs.color-highlight
        # Theme & Icons
        catppuccin.catppuccin-vsc
        catppuccin.catppuccin-vsc-icons
        # Python
        ms-python.python
        ms-python.vscode-pylance
        ms-python.debugpy
        batisteo.vscode-django
        # Java
        redhat.java
        vscjava.vscode-java-debug
        vscjava.vscode-java-test
        vscjava.vscode-maven
        # Go
        golang.go
        # Rust
        rust-lang.rust-analyzer
        # Project Manager
        alefragnani.project-manager
        # Remote
        ms-vscode-remote.remote-ssh
        ms-vscode-remote.remote-containers
        ms-vscode.remote-explorer
      ] ++ (pkgs.vscode-utils.extensionsFromVscodeMarketplace [
        # Synthwave theme
        {
          name = "synthwave-vscode";
          publisher = "RobbOwen";
          version = "0.1.15";
          sha256 = "sha256-bcjUWB0/agSoFAsFdh1a+RYOF12J2XQY3GCv400+Pb4=";
        }
        # One Dark Pro theme
        {
          name = "Material-theme";
          publisher = "zhuangtongfa";
          version = "3.19.0";
          sha256 = "sha256-K0eXeAEn4s3YZHJJU9jxtytNQTgaGwvd3fBUsZiKfPw=";
        }
        # Material Icon Theme
        {
          name = "material-icon-theme";
          publisher = "PKief";
          version = "5.15.0";
          sha256 = "sha256-wIde2Kz9+peLycRjx78yXDF3lMPUEO1TCqN925rZEOw=";
        }
        # Live Sass
        {
          name = "live-sass";
          publisher = "glenn2223";
          version = "6.1.3";
          sha256 = "sha256-mlhRmbpevjKPMOeSdBYUXkaIL0VMcck1tI2w6MzQhNM=";
        }
        # Live Server
        {
          name = "LiveServer";
          publisher = "ritwickdey";
          version = "5.7.9";
          sha256 = "sha256-w0CYSEOdltwMFzm5ZhOxSrxqQ1y4+gLfB8L+EFFgzDc=";
        }
        # Better Jinja
        {
          name = "jinjahtml";
          publisher = "samuelcolvin";
          version = "0.20.0";
          sha256 = "sha256-wADL3AkLfT2N9io8h6XYgceKyltJCz5ZHZhB14ipqpM=";
        }
        # Auto Close Tag
        {
          name = "auto-close-tag";
          publisher = "formulahendry";
          version = "0.5.15";
          sha256 = "sha256-8lRdNGa7Shhmko8lhKxexNj4mkGEwPihBrsQrm5a1kA=";
        }
        # Auto Import
        {
          name = "autoimport";
          publisher = "steoates";
          version = "1.5.4";
          sha256 = "sha256-7iIwJJsoNbtTopc+BQ+195aSCLqdNAaGtMoxShyhBWY=";
        }
        # CodeSnap
        {
          name = "codesnap";
          publisher = "adpyke";
          version = "1.3.4";
          sha256 = "sha256-dR6qODSTK377OJpmUqG9R85l1sf9fvJJACjrYhSRWgQ=";
        }
        # Error Lens
        {
          name = "errorlens";
          publisher = "usernamehw";
          version = "3.20.0";
          sha256 = "sha256-0gCT+u6rfkEcWcdzqRdc4EosROllD/Q0TIOQ4k640j0=";
        }
        # HTML CSS Support
        {
          name = "vscode-html-css";
          publisher = "ecmel";
          version = "2.0.9";
          sha256 = "sha256-fDDVfS/5mGvV2qLJ9R7EuwQjnKI6Uelxpj97k9AF0pc=";
        }
        # Jinja (wholroyd)
        {
          name = "jinja";
          publisher = "wholroyd";
          version = "0.0.8";
          sha256 = "sha256-kU2uMIBChHOE76npA9u1CSJCMPHK0hj/2vasVTx9ydI=";
        }
        # Remote - SSH: Edit Configuration Files
        {
          name = "remote-ssh-edit";
          publisher = "ms-vscode-remote";
          version = "0.87.0";
          sha256 = "sha256-yeX6RAJl07d+SuYyGQFLZNcUzVKAsmPFyTKEn+y3GuM=";
        }
        # Sass (.sass only)
        {
          name = "sass-indented";
          publisher = "syler";
          version = "1.8.22";
          sha256 = "sha256-i1z9WTwCuKrfU4AhdoSvGEunkk8gdStsod8jHTEnoFY=";
        }
        # vscode-icons
        {
          name = "vscode-icons";
          publisher = "vscode-icons-team";
          version = "12.10.0";
          sha256 = "sha256-GNDLuszuJN3P0V25F4gm7yUJsFEQgFMMPMTFLWLIvSo=";
        }
      ]);
    })
    spotify
    prismlauncher
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
    WLR_NO_HARDWARE_CURSORS = "1";
    GST_PLUGIN_SYSTEM_PATH_1_0 = "${pkgs.gst_all_1.gst-plugins-base}/lib/gstreamer-1.0:${pkgs.gst_all_1.gst-plugins-good}/lib/gstreamer-1.0:${pkgs.gst_all_1.gst-plugins-bad}/lib/gstreamer-1.0";
    LIBVA_DRIVER_NAME = "nvidia";
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    NVD_BACKEND = "direct";
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
    shell = pkgs.zsh;
  };
  # -----------------------
  # UNFREE PACKAGES
  # -----------------------
  nixpkgs.config = {
    allowUnfree = true;
#    cudaSupport = true;
  };
  system.stateVersion = "25.11";
}
