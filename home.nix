{ inputs, config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "filk";
  home.homeDirectory = "/home/filk";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "26.05"; # Please read the comment before changing.

  nixpkgs.config = {
    allowUnfree = true;
    allowUnfreePredicate = (_: true);
  };

  imports =
    [
      ./bash.nix
      ./hyprland2.nix
      ./waybar.nix
      ./stylix-h.nix
      ./ranger.nix
      ./zsh.nix
    ];

  # Minimize/Maximize Windows
  # dconf.settings."org/gnome/desktop/wm/preferences".button-layout = "minimize,maximize,close";


  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    #the good stuff
    vscodium-fhs
    jdk
    cmake
    pkg-config

    kdePackages.bluedevil
    # clamav

    uutils-coreutils    
    # qgis
    wttrbar
    # libvterm
    epy
    astroterm
    playerctl
    prismlauncher
    # zoom-us
    _4d-minesweeper
    google-chrome
    gcc_multi
    gimp3-with-plugins
    tlp
    # wineWowPackages.waylandFull
    winetricks
    protontricks
    protonup-ng
    kitty
    lolcat
    nyancat
    # r2modman
    gparted
    libreoffice
    mangal
    wayneko
    gotop
    btop
    ripgrep
    tree
    # copilot-language-server
    nixd
    lua-language-server
    
    networkmanager
    # mpd
    killall
    lm_sensors

    xhost
    font-awesome_5

    grimblast 
    obs-studio
    brightnessctl
    brillo
    cliphist
    wl-clipboard
    go
    dunst
    libnotify
    
    kdePackages.gwenview

   (callPackage ./endcord/derivation.nix {})
   (callPackage ./fracterm/derivation.nix {})
  ];

  home.sessionVariables = {
    EDITOR = "emacs";
    TERMINAL = "kitty";
    BROWSER = "librewolf";
    NIXPKGS_ALLOW_UNFREE=1;
  };

  # xdg.mimeApps = {
  #   enable = true;
  #   defaultApplications = {
  #     # LibreWolf as default browser
  #     "text/html" = "librewolf.desktop";
  #     "x-scheme-handler/http" = "librewolf.desktop";
  #     "x-scheme-handler/https" = "librewolf.desktop";
  #     "x-scheme-handler/about" = "librewolf.desktop";
  #     "x-scheme-handler/unknown" = "librewolf.desktop";
  #     "x-scheme-handler/chrome" = "librewolf.desktop";

  #     # Other defaults
  #     "application/json"="emacs.desktop";
  #     "application/pdf"="org.gnome.Evince.desktop";
  #     "application/x-extension-htm"="librewolf.desktop";
  #     "application/x-extension-html"="librewolf.desktop";
  #     "application/x-extension-shtml"="librewolf.desktop";
  #     "application/x-extension-xht"="librewolf.desktop";
  #     "application/x-extension-xhtml"="librewolf.desktop";
  #     "application/xhtml+xml"="librewolf.desktop";
  #     "application/xml"="codium.desktop";
  #     "application/zip"="org.gnome.FileRoller.desktop";
  #     "audio/x-mod"="codium.desktop";
  #     "image/gif"="org.kde.gwenview.desktop";
  #     "image/jpeg"="org.kde.gwenview.desktop";
  #     "image/png"="org.kde.gwenview.desktop";
  #     "text/plain"="org.gnome.TextEditor.desktop";
  #     "video/mp4"="vlc.desktop";
  #     "video/webm"="vlc.desktop";
  #     "x-scheme-handler/betterdiscord"="discord.desktop";
  #     "x-scheme-handler/discord"="vesktop.desktop";
  #   };
  # };

  programs.kitty = {
    enable = true;
    # theme = "Chalkboard";
    settings = {
      shell = "zsh";
    };
  };

  programs.vscodium = {
    enable = true;
    package = pkgs.vscodium.fhs;
    # profiles.default.extensions = with pkgs.vscode-extensions; [
    profiles.default.extensions = with pkgs.vscode-extensions; [
      # bbenoist.nix
      dotjoshjohnson.xml
      jnoortheen.nix-ide
      mshr-h.veriloghdl
      # redhat.vscode-xml
    ];
  };

  # programs.thefuck = {
  #   enable = true;
  #   # alias = "fuck";
  # };


  xdg.portal = {
    enable = true;
    xdgOpenUsePortal =  true;
    config.common.default = [
      "gtk"
      "hyprland"
    ];
    extraPortals = [
      pkgs.xdg-desktop-portal
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal-hyprland
      pkgs.xdg-desktop-portal-gnome
      pkgs.xdg-desktop-portal-wlr
      pkgs.kdePackages.xdg-desktop-portal-kde
    ];
  };

  programs.ncmpcpp = {
    enable = true;
    package = pkgs.ncmpcpp.override { visualizerSupport = true; };
    mpdMusicDir = "/home/filk/Music";
    settings = {
      visualizer_data_source = "/tmp/mpd.fifo";
      visualizer_output_name = "visualizer";
      visualizer_in_stereo = "yes";
      visualizer_type = "ellipse";
      visualizer_look = "󱄅|";
      visualizer_spectrum_smooth_look = "no";
    };
  };

  services.mpd-mpris.enable = true;
  programs.qutebrowser.enable = true;

  qt = {
    enable = false;
    # kvantum.enable = true;
    # platformTheme.name = "qtct";
    # style.name = "qt6ct";
  };

  programs.vim.enable = true;

  programs.vesktop = {
    enable = true;
    vencord = {
      settings = {
        plugins = {
          AlwaysTrust.enabled = true;
          BetterGifAltText.enabled = true;
          BetterGifPicker.enabled = true;
          BetterRoleContext.enabled = true;
          CallTimer.enabled = true;
          ClearURLs.enabled = true;
          Decor.enabled = true;
          ExpressionCloner.enabled = true;
          FakeNitro = {
            enabled = true;
            transformCompoundSentence = true;
          };
          FavoriteGifSearch.enabled = true;
          FixYoutubeEmbeds.enabled = true;
          FriendsSince.enabled = true;
          FullSearchContext.enabled = true;
          GameActivityToggle.enabled = true;
          ImageLink.enabled = true;
          ImplicitRelationships.enabled = true;
          InvisbleChat.enabled = true;
          MentionAvatars.enabled = true;
          NoReplyMention.enabled = true;
          PermissionsViewer.enabled = true;
          petpet.enabled = true;
          PinDMs.enabled = true;
          ReverseImageSearch.enabled = true;
          SendTimestamps.enabled = true;
          ServerInfo.enabled = true;
          ShowHiddenChannels.enabled = true;
          ShowHiddenThings.enabled = true;
          SilentTyping.enabled = true;
          TypingIndicator.enabled = true;
          TypingTweaks.enabled = true;
          VencordToolbox.enabled = true;
          VolumeBooster.enabled = true;
          WhoReacted.enabled = true;
          YoutubeAdblock.enabled = true;
        };
      };
    };
  };

  # Fix this all later

  # wayland.windowManager.hyprland = {
  #   enable = true;
  #   plugins = [
  #     inputs.hyprland-plugins.packages.${pkgs.system}.hyprbars
  #     # ...
  #   ];
  # };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  }
