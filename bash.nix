{config, pkgs, ...}:

{
  programs.bash = {
    enable = true;
    shellAliases = {
     lt = "ls -h -s -1 -S --classify";
     ll = "ls -l";
      ".." = "cd ..";
      c = "clear";
      fetchneo = "nix-shell -p neofetch";
      gpart = "sudo -E gparted";
      qud = "steam-run ~/Games/Caves/start.sh";

      # NixOS Config aliases
      dotf = "cd ~/.dotfiles";
      dotfconf = "codium ~/.dotfiles";
      etcnix = "cd /etc/nixos";
      hrebuild = "home-manager switch --flake .";
      srebuild = "sudo nixos-rebuild switch --flake .";
      sqebuild = "sudo nixos-rebuild switch --flake . --impure";
      flakeup = "sudo nix flake update";
      cleanup = "sudo nix-collect-garbage --delete-older-than 7d && nix-collect-garbage --delete-older-than 7d";
      sysconfig = "codium ~/.dotfiles/configuration.nix";
      homeconfig = "codium ~/.dotfiles/home.nix";
      flakeconfig = "codium ~/.dotfiles/flake.nix";
      
      # Coding aliases
      demacs = "emacs --daemon";
      phyfiles = "cd ~/Documents/Physics";
      phydev = ''cd ~/Documents/Physics
      nix-shell'';

      haskdev = "";
    };
    bashrcExtra = ''
      export PATH="$HOME/.config/emacs/bin:$PATH"
      cat ~/.dotfiles/nixowows-banner.txt | lolcat
    '';
  };
}
