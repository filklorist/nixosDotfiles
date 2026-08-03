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
  home.stateVersion = "24.05"; # Please read the comment before changing.

  nixpkgs.config = {
    allowUnfree = true;
    allowUnfreePredicate = (_: true);
  };

  imports =
    [
      ./bash.nix
      # ./hyprland.nix
      # ./waybar.nix
      ./stylix-h.nix
      ./ranger.nix
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
    # vesktop
    # qgis
    # wttrbar
    # libvterm
    # epy
    # astroterm
    # playerctl
    prismlauncher
    # zoom-us
    # _4d-minesweeper
    google-chrome
    gcc_multi
    gimp3
    # tlp
    # wineWowPackages.waylandFull
    # winetricks
    # protontricks
    # protonup
    kitty
    lolcat
    # nyancat
    # r2modman
    gparted
    libreoffice
    mangal
    # wayneko
    gotop
    # btop
    ripgrep

    # copilot-language-server
    nixd
    lua-language-server
    
    networkmanager
    # mpd
    killall
    lm_sensors

    # hyprland
    xorg.xhost
    font-awesome_5
    # leaf
    # python313Packages.pip

    # grimblast 
    # obs-studio
    # brightnessctl
    # brillo
    # cliphist
    # wl-clipboard
    # go
    # dunst
    # libnotify

    imv
    # kdePackages.gwenview

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
    EDITOR = "codium";
    TERMINAL = "kitty";
    BROWSER = "firefox";
    NIXPKGS_ALLOW_UNFREE=1;
  };

  programs.kitty = {
    enable = true;
    # theme = "Chalkboard";
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
