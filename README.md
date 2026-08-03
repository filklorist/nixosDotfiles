NOTES FOR INSTALL:

Either don't grab the hardware config, or get the proper disk uuid from the /etc/nixos hardware conf file



put 

```nix.settings.experimental-features = [ "nix-command" "flakes" ];```
  
in etc nix conf



command to rebuild is 

```sudo nixos-rebuild switch```
  
append

```--flake .```
  
when flakes are wanted



home manager needs to be manually installed

```https://nix-community.github.io/home-manager/index.xhtml#sec-install-standalone```
  
then can be rebuilt with 

```home-manager switch --flake .```

  

and for fingerprint

```https://github.com/NixOS/nixos-hardware/tree/master/framework/13-inch/13th-gen-intel```
