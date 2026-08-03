{ inputs, config, pkgs, ...}:
{

  # Enable the uinput module
  boot.kernelModules = [ "uinput" ];

  # Enable uinput
  hardware.uinput.enable = true;

  # Set up udev rules for uinput
  # services.udev.extraRules = ''
  #   KERNEL=="uinput", MODE="0660", GROUP="uinput", OPTIONS+="static_node=uinput"
  # '';

  # Ensure the uinput group exists
  users.groups.uinput = { };

  systemd.services.kanata-test1.serviceConfig = {
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
      ];
      config = ''
      (defsrc
        9    =
        rctl o
      )

      (deflayer default
        _     _
        @rctl _
      )

      (deflayer press
        0    -
        _    p
      )

      (defalias
        rctl (tap-hold 0 10 rctl (layer-toggle press))
      )
      '';
      extraDefCfg = "process-unmapped-keys yes";
    };

  };
}
