{ inputs, config, pkgs, lib, ... }:

{
  wayland.windowManager.hyprland = {
    configType = "lua";
    # Whether to enable Hyprland wayland compositor
    enable = true;
    # The hyprland package to use
    package = pkgs.hyprland;
    # Whether to enable XWayland
    xwayland.enable = true;

    # Optional
    # Whether to enable hyprland-session.target on hyprland startup
    systemd.enable = true;

    settings = {
      mod = {
        _var = "SUPER";
      };

      monitor = {
        
      };
      config = {
        general = {
          gaps_in = 5;
          gaps_out = 20;
          border_size = 2;
        };

        decoration = {
          rounding = 10;
        };
      };

      bind = [
        {
          _args = [
            (lib.generators.mkLuaInline "mod .. \" + Q\"")
            (lib.generators.mkLuaInline "hl.dsp.window.close()")
            { locked = true; }
          ];
        }
        {
          _args = [
            "SUPER + RETURN"
            (lib.generators.mkLuaInline "hl.dsp.exec_cmd(\"kitty\")")
          ];
        }
        {
          _args = [
            "ALT + R"
            (lib.generators.mkLuaInline "hl.dsp.submap(\"resize\")")
          ];
        }
      ];

      define_submap = {
        _args = [
          "resize"
          (lib.generators.mkLuaInline "function()\n  hl.bind(\"right\", hl.dsp.window.resize({ x = 10, y = 0, relative = true }), { repeating = true })\n  hl.bind(\"left\", hl.dsp.window.resize({ x = -10, y = 0, relative = true }), { repeating = true })\n  hl.bind(\"escape\", hl.dsp.submap(\"reset\"))\nend")
        ];
      };

      window_rule = {
        match.class = "kitty";
        border_size = 2;
      };

      # on = {
      #   _args = [
      #     "hyprland.start"
      #     (lib.generators.mkLuaInline "function()\n  hl.exec_cmd(\"waybar\")\nend")
      #   ];
      # };
    };
  };
}
