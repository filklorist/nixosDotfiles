{
  description="First Flake";



  inputs = {
    # Core dependencies
    # Uncomment unstable to break everything probably
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    # nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
    home-manager.url = "github:nix-community/home-manager/";
    # home-manager.url = "github:nix-community/home-manager/release-24.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # Hyprland+plugins (which I don't really use, maybe axe them)
    hyprland.url = "github:hyprwm/Hyprland";
    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };

    # Extras
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    emacs-overlay = {
      url = "github:nix-community/emacs-overlay";
      # inputs.nixpkgs.follows = "nixpkgs";
    };

    # Swap which stylix url is commented if stable -> unstable
    # stylix.url = "github:danth/stylix/release-24.11";
    stylix.url = "github:danth/stylix";

    rose-pine-hyprcursor = {
      url = "github:ndom91/rose-pine-hyprcursor";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.hyprlang.follows = "hyprland/hyprlang";
    };
  };
  

  outputs = { self, nixpkgs, home-manager, nixos-hardware, stylix, ...} @ inputs: 
    let

      lib = nixpkgs.lib;

      systemSettings = {
        system = "x86_64-linux";
      };

      nixpkgs-patched = (import inputs.nixpkgs {system = systemSettings.system;}).applyPatches {
        name = "nixpkgs-patched";
        src = inputs.nixpkgs;
        patches = [
          # ./patches/emacs-no-version-check.patch
        ];
      };

      pkgs = import nixpkgs-patched {
        system = systemSettings.system;
        overlays = [
          # inputs.emacs-overlay
        ];
      };

    in {
      nixosConfigurations = {
        nixos = lib.nixosSystem {
          specialArgs = { 
            inherit systemSettings;
            inherit inputs;
          }; 
          system = systemSettings.system;
          modules = [ 
            ./configuration.nix 
            stylix.nixosModules.stylix
            nixos-hardware.nixosModules.framework-13th-gen-intel
          ];
        };
      };
      homeConfigurations = {
        jonah = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          extraSpecialArgs = { 
            inherit inputs;
          }; 
          modules = [
            ./home.nix 
            stylix.homeModules.stylix
          ];
        };
      };
    };

}
