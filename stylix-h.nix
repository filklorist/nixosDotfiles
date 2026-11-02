{ inputs, config, pkgs, ...}:

{
    stylix = {
        # homeManagerIntegration.followSystem = true;
        enable = true;
        image = ./wallpapers/ryo.png;
        # image = ./wallpapers/simple_gruv.png;
        # image = ./wallpapers/Space_Trucker.png;
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
            base00 = "27171b";
            # base01 = "544b45";
            # base02 = "78726f";
            # base03 = "9d9999";
            # base04 = "c1c0c3";
            # base05 = "e6e7ed";
            # base06 = "eaeaef";
            # base07 = "edeef2";
            # base08 = "997c43";
            # base09 = "4d6fea";
            # base0A = "388bda";
            # base0B = "4a94dc";
            # base0C = "4d78bf";
            # base0D = "bd5d29";
            # base0E = "90b8ef";
            # base0F = "a26c40";
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
