# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ inputs, config, pkgs, lib, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./stylix-s.nix
      ./kanata.nix
      ./emacs.nix
      # <nixos-hardware/framework/13-inch/13th-gen-intel>
      # "${builtins.fetchGit { url = "https://github.com/NixOS/nixos-hardware.git"; }}/framework/13-Inch/13th-gen-intel"
    ];
  
  services.fwupd.enable = true;
  # we need fwupd 1.9.7 to downgrade the fingerprint sensor firmware
  services.fwupd.package = (import (builtins.fetchTarball {
    url = "https://github.com/NixOS/nixpkgs/archive/bb2009ca185d97813e75736c2b8d1d8bb81bde05.tar.gz";
    sha256 = "sha256:003qcrsq5g5lggfrpq31gcvj82lb065xvr7bpfa8ddsw8x4dnysk";
  }) {
    inherit (pkgs) system;
  }).fwupd;

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  # specialisation.plasma.configuration = {
  #   services.xserver.desktopManager.plasma5.enable = true;
  # };
  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking 
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/Los_Angeles";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  services.xserver.videoDrivers = [ "intel" ];

  # Enable the GNOME Desktop Environment.
  services.displayManager.gdm.enable = true;
  # services.desktopManager.gnome.enable = true;


  # Enable Hyprland <
  services.displayManager.gdm.wayland = true;

  programs.hyprland = {    
      enable = true;    
      xwayland.enable = true;    
      portalPackage = pkgs.xdg-desktop-portal-hyprland;
  }; 
  programs.waybar.enable = true;



  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "symbolic";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  # services.pulseaudio.enable = false;
  security.polkit.enable = true;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    wireplumber = {
      enable = true;
      # extraConfig = {
        # "10-disable-camera" = {
          # "wireplumber.profiles" = {
            # main."monitor.libcamera" = "disabled";
          # };
        # };
      # };
    };
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };
  services.mpd = {
    enable = true;
    musicDirectory = "/home/jonah/Music";
    settings = {
      audio_output = [
        {
          type = "pipewire";
          name = "My PipeWire Output";
        }
        {
          type = "fifo";
          name = "visualizer";
          path = "/tmp/mpd.fifo";
          format = "44100:16:2";
        }
      ];
    };
    user = "1000";
  };
  systemd.services.mpd.environment = {
    # https://gitlab.freedesktop.org/pipewire/pipewire/-/issues/609
    XDG_RUNTIME_DIR = "/run/user/1000"; # User-id must match above user. MPD will look inside this directory for the PipeWire socket.
  };
  # Enable touchpad support (enabled default in most desktopManager).
  services.libinput.enable = true;

  hardware.bluetooth = {
    enable = true;
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  environment.sessionVariables = {
    XDG_CURRENT_DESKTOP = "Hyprland";
    XDG_SESSION_DESKTOP = "Hyprland";
    XDG_SESSION_TYPE = "wayland";
    GDK_BACKEND = "wayland";
    GTK_USE_PORTAL = "1";
    # QT_QPA_PLATFORMTHEME = "qt6ct";
    QT_QPA_PLATFORM = "wayland";
    WLR_NO_HARDWARE_CURSORS = "1";
    NIXOS_OZONE_WL = "1";
  };
  users.users.jonah = {
    isNormalUser = true;
    description = "Jonah";
    extraGroups = [ "networkmanager" "wheel" "uinput" "input" "scanner" "lp" ];
    packages = with pkgs; [
      firefox
      networkmanagerapplet
      libsForQt5.qtstyleplugin-kvantum
      # libsForQt5.lightly
      # libsForQt5.kdegraphics-thumbnailers
      libsForQt5.kio
      # libsForQt5.kio-extras
      # libsForQt5.ffmpegthumbs
      # libsForQt5.kimageformats
      # libsForQt5.dolphin-plugins
      # libsForQt5.qt5.qtsvg
      qt6Packages.qt6ct
      qt6.qtwayland
      qt5.qtwayland
      # kio-admin
      pulseaudioFull
      # texliveFull
    ];
  };

  # Enable automatic login for the user.
  services.displayManager.autoLogin.enable = true;
  services.displayManager.autoLogin.user = "jonah";

  # Workaround for GNOME autologin: https://github.com/NixOS/nixpkgs/issues/103746#issuecomment-945091229
  systemd.services."getty@tty1".enable = false;
  systemd.services."autovt@tty1".enable = false;

  # Allow unfree packages
  nixpkgs.config = {
    allowUnfree = true;
    allowUnfreePredicate = (_: true);
  };

  # Patch emacs package
  nixpkgs.overlays = [
    inputs.emacs-overlay.overlay
  ];

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    unar
    wget
    git
    steam
    # steam-tui
    # steamcmd
    steam-run
    rofi
    wofi
    audacity
    kdePackages.dolphin
    kdePackages.bluedevil
    waybar
    hyprpaper
    actkbd
    ani-cli
    pulsemixer
    kanata
    ispell
    bat
    eza
    w3m
    # pkgs.emacsGcc
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [ 7777 15777 15000 ];
  networking.firewall.allowedUDPPorts = [ 7777 15777 15000 ];
  # Or disable the firewall altogether.
  networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?

  nix.settings = {
    experimental-features = [ 
      "nix-command" 
      "flakes" 
    ];
    download-buffer-size = "2G";
  };
  
  programs.java.enable = true; 

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
    extraCompatPackages = with pkgs; [
      proton-ge-bin
    ];
    # package = pkgs.steam.override {
      # withPrimus = true;
      # withJava = true;
      # extraPkgs = pkgs: [ bumblebee glxinfo ];
    # };
  };
  programs.steam.gamescopeSession.enable = true;

  # sound.enable = true;

  hardware.graphics ={
    enable = true;
    enable32Bit = true;
    extraPackages = [ pkgs.vpl-gpu-rt ];
    # extraPackages32 = [ pkgs.driversi686Linux.amdvlk ];
  };


  services.power-profiles-daemon.enable = false;

  services.thermald.enable = true;
  services.tlp = {
    enable = true;
    settings = {
      # CPU_SCALING_GOVERNOR_ON_AC = "performance";
      CPU_SCALING_GOVERNOR_ON_AC = "powersave";
      # CPU_SCALING_GOVERNOR_ON_BAT = "performance";
      CPU_SCALING_GOVERNOR_ON_BAT = "powersave";

      CPU_ENERGY_PERF_POLICY_ON_BAT = "low-power";
      # CPU_ENERGY_PERF_POLICY_ON_BAT = "performance";
      CPU_ENERGY_PERF_POLICY_ON_AC = "low-power";
      # CPU_ENERGY_PERF_POLICY_ON_AC = "performance";

      CPU_BOOST_ON_BAT = 0;
      CPU_HWP_DYN_BOOST_ON_BAT = 0;

      CPU_MIN_PERF_ON_AC = 0;
      CPU_MAX_PERF_ON_AC = 30;
      # CPU_MAX_PERF_ON_AC = 100;
      CPU_MIN_PERF_ON_BAT = 0;
      CPU_MAX_PERF_ON_BAT = 15;
      # CPU_MAX_PERF_ON_BAT = 100;

      #Optional helps save long term battery health
      START_CHARGE_THRESH_BAT0 = 40; # 40 and bellow it starts to charge
      STOP_CHARGE_THRESH_BAT0 = 80; # 80 and above it stops charging
      START_CHARGE_THRESH_BAT1 = 40; # 40 and bellow it starts to charge
      STOP_CHARGE_THRESH_BAT1 = 80; # 80 and above it stops charging

    };
  };

  # For now
  fonts = {
    fontconfig.enable = true;
  #   packages = with pkgs; [ nerdfonts ];
  };

  # Once unstable is more stable use these
  fonts.packages = with pkgs.nerd-fonts; [
    noto
    # wqy_zenhei
    liberation
    fira-code
    # fira-code-symbols
    # mplus-outline-fonts.githubRelease
    # dina-font
    proggy-clean-tt
    # nerdfonts
    # font-awesome
    # powerline-fonts
    # powerline-symbols
    bigblue-terminal
    dejavu-sans-mono
    heavy-data
    monofur
    terminess-ttf
    go-mono
    shure-tech-mono
    # 0xproto
    tinos
    cousine
    code-new-roman
  ];

  qt = {
    enable = true;
    # platformTheme = "qt6ct";
  };

  programs.zsh.enable =  true;

  # Can probably remove, superseded by Kanata
  services.actkbd = {
    enable = true;
    bindings = [
      { keys = [ 53 97 ]; events = [ "key" ]; command = "key(0xffff),rel(0xffff),noexec"; }
    ];
  };

  programs.nm-applet.enable = true;

  # services.logmein-hamachi.enable = true;

}
