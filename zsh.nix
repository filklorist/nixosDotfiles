{ config, lib, pkgs, ... }:
let
  agnoster-nix-theme = builtins.fetchurl {
    url = "https://gist.githubusercontent.com/chisui/0d12bd51a5fd8e6bb52e6e6a43d31d5e/raw/a97b74ce17c5f1befabe266ccf02a972cab2911b/agnoster-nix.zsh-theme";
    sha256 = "1m7qqrp8z0glnq81c9ldzmm0r42rgdmw8nk9hvssbjphx5khk6z7";
  };
  customDir = pkgs.stdenv.mkDerivation {
    name = "oh-my-zsh-custom-dir";
    phases = [ "buildPhase" ];
    buildPhase = ''
      mkdir -p $out/themes
      cp ${agnoster-nix-theme} $out/themes/agnoster-nix.zsh-theme
    '';
  };
in
{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    plugins = [
      {
        name = "zsh-nix-shell";
        file = "nix-shell.plugin.zsh";
        src = pkgs.fetchFromGitHub {
          owner = "chisui";
          repo = "zsh-nix-shell";
          rev = "v0.8.0";
          sha256 = "1lzrn0n4fxfcgg65v0qhnj7wnybybqzs4adz7xsrkgmcsr0ii8b7";
        };
      }
    ];

    oh-my-zsh = {
      enable = true;
      plugins = [ "git" ];
      # theme = "agnoster-nix";
      custom = "${customDir}";
    };
    shellAliases = config.programs.bash.shellAliases;
    initContent = ''
      PROMPT1="%U%F{magenta}%n%f%u@%U%F{blue}%m%f%u:%F{yellow}%~%f"
      PROMPT2="%F{green}→%f "
      PROMPT=" ◉ ''${PROMPT1}
        ''${PROMPT2}"
      RPROMPT="%F{red}▂%f%F{yellow}▄%f%F{green}▆%f%F{cyan}█%f%F{blue}▆%f%F{magenta}▄%f%F{white}▂%f"
      [ $TERM = "dumb" ] && unsetopt zle && PS1='$ '
      if [[ -n "$IN_NIX_SHELL" ]]; then
         if [[ -n "$NIX_SHELL_PACKAGES" ]]; then
            local package_names=""
            local packages=($NIX_SHELL_PACKAGES)
            for package in $packages; do
                package_names+="%F{cyan}{$package}%f "
            done
            PROMPT=" %F{white}%f ''${PROMPT1}
       ''${package_names}''${PROMPT2}"
         fi
      fi
      bindkey '^P' history-beginning-search-backward
      bindkey '^N' history-beginning-search-forward
      '';

  };
}
