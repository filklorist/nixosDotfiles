{ inputs, config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "jonah";
  home.homeDirectory = "/home/jonah";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.05"; # Please read the comment before changing.

  nixpkgs.config = {
    allowUnfree = true;
    allowUnfreePredicate = (_: true);
  };

  imports =
    [
      ./bash.nix
      ./hyprland.nix
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
    bc

    #the good stuff
    vscodium-fhs
    vlc
    jdk
    cmake
    pkg-config
    # clamav
    # discord
    # vesktop
    uutils-coreutils
    spotify
    qgis
    librewolf
    wttrbar
    libvterm
    epy
    astroterm
    playerctl
    # prismlauncher
    zoom-us
    betterdiscordctl
    _4d-minesweeper
    legendary-gl
    google-chrome
    gcc_multi
    mpc

    fancontrol-gui
    nwg-look
    # GNOME apps added because I got rid of Gnome
    glib
    evince
    nautilus
    file-roller
    gnome-text-editor

    # gimp3
    rose-pine-cursor
    gimp3-with-plugins
    # gimp3Plugins.resynthesizer
    tlp
    # wineWowPackages.waylandFull
    wineWowPackages.stable
    winetricks
    protontricks
    protonup-ng
    kitty
    lolcat
    # nyancat
    # r2modman
    gparted
    libreoffice
    sherlock
    lutris
    heroic
    mangal
    # wayneko
    gotop
    btop
    ripgrep

    # copilot-language-server
    nixd
    lua-language-server

    networkmanager
    killall
    lm_sensors

    hyprland
    xorg.xhost
    font-awesome_5
    libsForQt5.qt5ct
    qt6Packages.qt6ct
    leaf
    python313Packages.pip

    grimblast 
    obs-studio
    brightnessctl
    brillo
    cliphist
    wl-clipboard
    go
    dunst
    libnotify
    # swayidle
    # swaylock
    # hypridle

    imv
    kdePackages.gwenview
    # gnome extensions
    # gnomeExtensions.dash-to-dock
    # gnomeExtensions.system-monitor-2
    # gnomeExtensions.arcmenu
    # gnomeExtensions.blur-my-shell
    # gnomeExtensions.just-perfection
    # gnomeExtensions.rounded-window-corners
    # gnomeExtensions.vitals
    # gnomeExtensions.appindicator


    # gnome-tweaks
    # gnome-boxes
    # gnome-software
    # gnome-shell
    # gnome-shell-extensions
    # gnome-extension-manager

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. If you don't want to manage your shell through Home
  # Manager then you have to manually source 'hm-session-vars.sh' located at
  # either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/jonah/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    EDITOR = "emacs";
    TERMINAL = "kitty";
    BROWSER = "librewolf";
    NIXPKGS_ALLOW_UNFREE=1;
  };

  # home.pointerCursor = {
  #   name = "MarsCursor";
  #   size = 64;
  #   hyprcursor = {
  #     enable =  true;
  #   };
  # };

  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      # LibreWolf as default browser
      "text/html" = "librewolf.desktop";
      "x-scheme-handler/http" = "librewolf.desktop";
      "x-scheme-handler/https" = "librewolf.desktop";
      "x-scheme-handler/about" = "librewolf.desktop";
      "x-scheme-handler/unknown" = "librewolf.desktop";
      "x-scheme-handler/chrome" = "librewolf.desktop";

      # Other defaults
      "application/json"="emacs.desktop";
      "application/pdf"="org.gnome.Evince.desktop";
      "application/x-extension-htm"="librewolf.desktop";
      "application/x-extension-html"="librewolf.desktop";
      "application/x-extension-shtml"="librewolf.desktop";
      "application/x-extension-xht"="librewolf.desktop";
      "application/x-extension-xhtml"="librewolf.desktop";
      "application/xhtml+xml"="librewolf.desktop";
      "application/xml"="codium.desktop";
      "application/zip"="org.gnome.FileRoller.desktop";
      "audio/x-mod"="codium.desktop";
      "image/gif"="org.kde.gwenview.desktop";
      "image/jpeg"="org.kde.gwenview.desktop";
      "image/png"="org.kde.gwenview.desktop";
      "text/plain"="org.gnome.TextEditor.desktop";
      "video/mp4"="vlc.desktop";
      "video/webm"="vlc.desktop";
      "x-scheme-handler/betterdiscord"="discord.desktop";
      "x-scheme-handler/discord"="vesktop.desktop";
    };
  };

  programs.kitty = {
    enable = true;
    # theme = "Chalkboard";
  };

  programs.vscode = {
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

  qt = {
    enable = true;
    # platformTheme.name = "qtct";
    # style.name = "qt6ct";
  };

  programs.ncmpcpp = {
    enable = true;
    package = pkgs.ncmpcpp.override { visualizerSupport = true; };
    mpdMusicDir = "/home/jonah/Music";
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

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  }
