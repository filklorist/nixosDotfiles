{ inputs, config, pkgs, ...}:
{

  services.kanata = {
    enable = true;
    keyboards.test1 = {
      devices = [
        "/dev/input/event0"
        "/dev/input/event1"
      ];
      config = ''
      (defsrc
        lctl i      9 = voldwn
        rctl /      o 2 w      rght
      )

      (deflayer default
        @ctl1 _     _ _ _
        @rctl _     _ _ _ _
      )

      (deflayer press
        _     8     0 - volu
        _     prtsc p 3 e      lft
      )

      (deflayer double
        @ctl2 8     0 - volu
        _     prtsc p 3 e      lft
      )

      (defalias
        ctl1 (tap-dance 500 (lctl (layer-switch double)))
        ctl2 (tap-dance 500 (lctl (layer-switch default)))
        rctl (tap-hold 0 10 rctl (layer-toggle press))
      )
      '';
      extraDefCfg = "process-unmapped-keys yes";
    };
  };

}