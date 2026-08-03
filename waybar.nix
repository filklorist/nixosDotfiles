{config, pkgs, ...}:

{
    programs.waybar = {
        enable = true;
        settings = {
            mainBar = {
                layer = "top";
                position = "top";
                height = 56;
                output = [
                    "eDP-1"
                    "HDMI-A-1"
                ];
                modules-left = [
                    "hyprland/workspaces"
                    #"wlr/taskbar"
                    ];
                modules-center = [ "hyprland/window" ];
                modules-right = [ "custom/weather" "mpd" "pulseaudio" "cpu" "memory" "temperature" "backlight" "battery" "clock" "tray" ];

                "hyprland/workspaces" = {
                    disable-scroll = true;
                    all-outputs = true;
                    show-special = true;
                    format = "<sub>{icon}</sub>\n{windows}";
                    window-rewrite-default = "";
                    window-rewrite = {
                        "class<firefox>" = "";
                        "class<vesktop>" = "";
                        "class<google-chrome>" = "󰊯";
                        "class<kitty>" = "";
                        "class<emacs>" = "";
                        "class<codium>" = "";
                        "class<gimp>" = "";
                        "title<ranger>" = "";
                        "class<org.prismlauncher.PrismLauncher>" = "";
                        "class<librewolf>" = "";
                        "class<steam>" = "";
                        "class<steam_app_548430>" = "󰢷";
                        "class<Tabletop Simulator.x86_64>" = "";
                        "class<CoQ.x86_64>" = "";
                        "class<vlc>" = "󰕼";
                    };
                };
                "custom/hello-from-waybar" = {
                    format = "hello {}";
                    max-length = 40;
                    interval = "once";
                    exec = pkgs.writeShellScript "hello-from-waybar" ''
                        echo "from within waybar"
                    '';
                };
                "custom/weather" = {
                    "format" = "{}";
                    "tooltip" = true;
                    "interval" = 3600;
                    "exec" = "wttrbar --nerd --location blue+lake";
                    "return-type" = "json";
                };
                "battery" = {
                    format = "{capacity}% {icon}";
                    format-icons = [""
                                      ""
                                      ""
                                      ""
                                      ""];
                };
                "clock" = {
                    # timezone = "America/New_York";
                    tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
                    format-alt = "{:%b %d, %Y}";
                };
                "pulseaudio" = {
                    format = "{volume}% 󰋋";
                };
                "cpu" = {
                    format = "{}% ";
                };
                "memory" = {
                    format = "{}% ";
                };
                "backlight" = {
                    format = "{percent}% {icon}";
                    format-icons = [""
                                    ""];
                };
                "temperature" = {
                    thermal-zone = 2;
                    format = "{temperatureC}°C ";
                };
            };
        };
        style = ''
              * {
                  font-size: 16px;
              }
               tooltip {
                  background: alpha(@base00, 0.95);
                  font-size: 22px;
              }
             .modules-left #workspaces * {
                  font-size: 22px;
              }

              .modules-right #weather { background-color: alpha(@base00,0.7) }
              .modules-right #pulseaudio { background-color: alpha(@base01,0.7)}
              .modules-right #cpu { background-color: alpha(@base00,0.7)}
              .modules-right #memory { background-color: alpha(@base01,0.7)}
              .modules-right #temperature { background-color: alpha(@base00,0.7)}
              .modules-right #backlight { background-color: alpha(@base01,0.7)}
              .modules-right #battery { background-color: alpha(@base00,0.7)}
              .modules-right #clock { background-color: alpha(@base01,0.7)}
              .modules-right #tray { background-color: alpha(@base00,0.7)}
        '';
    };
  
}
