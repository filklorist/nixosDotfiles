{ inputs, config, pkgs, ...}:

{
    stylix = {
        # homeManagerIntegration.followSystem = true;
        # image = ./current_wallpaper.jpg;
        enable = true;
        # image = ./current_wallpaper.png;
        image = ./simple_gruv.png;
        # image = ./recent_walk.jpg;
        # image = ./Space_Trucker.png;
        targets = {
            # hyprland.enable = true;
            # waybar.enable = true;
            vesktop.enable = true;
            qt.enable = false;
            # qt.platform = "qtct";
        };
        # targets.qt.enable = true;
        polarity = "dark";
        base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-dark.yaml";

        override = {
        #     base00 = "203d21";
            # base01 = "2d1d0b";
        #     base01 = "ff0018";
        #     base02 = "762200";
        #     base03 = "ff00e2";
        #     base04 = "244e04";
        #     base05 = "00ff29";
        #     base06 = "393d02";
        #     base07 = "f0ff1e";
        #     base08 = "636820";
        #     base09 = "08fe03";
        #     base0A = "38495b";
        #     base0B = "eeaa79";
        #     base0C = "ff5c02";
        #     base0D = "00ebff";
        #     # base0E = "";
        #     # base0F = "";
        };
        # cursor = {
        #     package = inputs.rose-pine-hyprcursor.packages.${pkgs.system}.default;
        #     name = "BreezX-RosePine-Linux";
        #     size = 32;
        # };

        opacity = {
            desktop = 0.2;
        #     terminal = 0.8;
        #     applications = 0.9;
        };

        fonts = {
            sizes = {
                terminal = 10;
            };
            serif = {
                package = pkgs.nerd-fonts.bigblue-terminal;
                # package = pkgs.nerdfonts;
                # name = "DejaVuSansM Nerd Font";
                name = "BigBlueTermPlus Nerd Font Propo";
            };

            sansSerif = {
                # package = pkgs.nerdfonts;
                package = pkgs.nerd-fonts.bigblue-terminal;
                # name = "DejaVuSansM Nerd Font";
                name = "BigBlueTermPlus Nerd Font Propo";
            };

            monospace = {
                # package = pkgs.nerdfonts;
                package = pkgs.nerd-fonts.bigblue-terminal;
                # name = "DejaVuSansM Nerd Font";
                name = "BigBlueTermPlus Nerd Font Mono";
            };

            emoji = {
                package = pkgs.noto-fonts-monochrome-emoji;
                name = "Noto Emoji";
            };
        };
    };
}
