{ inputs, config, pkgs, ...}:
{

  # Enable the uinput module
  boot.kernelModules = [ "uinput" ];

  # Enable uinput
  hardware.uinput.enable = true;

  # Set up udev rules for uinput
  services.udev.extraRules = ''
    KERNEL=="uinput", MODE="0660", GROUP="uinput", OPTIONS+="static_node=uinput"
  '';

  # Ensure the uinput group exists
  users.groups.uinput = { };

  # Add the Kanata service user to necessary groups
  systemd.services.kanata-internalKeyboard.serviceConfig = {
    SupplementaryGroups = [
      "input"
      "uinput"
    ];
  };

  services.kanata = {
    enable = true;
    keyboards.test1 = {
      devices = [
        "/dev/input/event0"
        "/dev/input/event1"
          # "/dev/input/by-path/platform-i8042-serio-0-event-kbd"
          # "/dev/input/by-path/pci-0000:00:14.0-usb-0:1:1.0-event-kbd"
      ];
      config = ''
      (defsrc
        /     '     down ]
        ralt        rght del
      )

      (deflayer default
        _     _     _    _
        @ralt       _    _
      )

      (deflayer press
        spc   enter up   \
        _           left bspc
      )

      (defalias
        ralt (tap-hold 0 10 ralt (layer-toggle press))
      )
      '';
      extraDefCfg = "process-unmapped-keys yes";
    };
  };

}
