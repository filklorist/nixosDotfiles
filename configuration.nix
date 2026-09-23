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
    ];

  # services.fwupd.enable = true;

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

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
  # You can disable this if you're only using the Wayland session.
  services.xserver.enable = true;
  services.xserver.videoDrivers = [ "intel" ];

  # Enable the KDE Plasma Desktop Environment.
  services.displayManager.plasma-login-manager.enable = true;
  services.desktopManager.plasma6.enable = true;

  # services.desktopManager.cosmic.enable = true;

  programs.hyprland = {    
    enable = true;    
    xwayland.enable = true;    
    portalPackage = pkgs.xdg-desktop-portal-hyprland;
  }; 
  programs.waybar.enable = true;

  # Configure keymap in X11
  services.xserver = {
    xkb = {
      layout = "us";
      variant = "";
    };
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable & configure Music Player Daemon
  services.mpd = {
    enable = true;
    musicDirectory = "/home/filk/Music";
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
  services.xserver.libinput.enable = true;

  # Add system variables for Hyprland
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

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users."filk" = {
    isNormalUser = true;
    description = "filklorist";
    extraGroups = [ "networkmanager" "wheel" "uinput" "input" "scanner" "lp" ];
    packages = with pkgs; [
      kdePackages.kate
      pulseaudioFull
      librewolf
      networkmanagerapplet
    #  thunderbird
    ];
  };

  # Install firefox.
  programs.firefox.enable = true;

  # Enable automatic login for the user.
  services.displayManager.autoLogin.enable = true;
  services.displayManager.autoLogin.user = "filk";

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
  #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    unar 
    git 
    steam 
    steam-run
    rofi 
    wofi 
    audacity 
    waybar
    # hyprpaper
    actkbd
    ani-cli 
    pulsemixer 
    kanata 
    ispell
    bat
    eza 
    w3m
    mpv
    (pkgs.xsane.override { gimpSupport = true; })
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
  system.stateVersion = "26.05"; # Did you read the comment?

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
  
  hardware.bluetooth = {
    enable = true;
  };

  hardware.graphics ={
    enable = true;
    # driSupport = true;
    enable32Bit = true;
    # extraPackages32 = [ pkgs.driversi686Linux.amdvlk ];
  };

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
    hack
    hasklug
    # 0xproto
    tinos
    cousine
    code-new-roman
  ];

  programs.zsh.enable =  true;
  
  programs.gnome-disks = {
    enable = true;
  };

  programs.nm-applet.enable = true;


  nix.settings = {
    experimental-features = [ 
      "nix-command" 
      "flakes" 
    ];
    download-buffer-size = "2G";
  };
}
