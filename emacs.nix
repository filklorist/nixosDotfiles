{ inputs, config, pkgs, ...}:

{
  environment.systemPackages = [
      (pkgs.emacsWithPackagesFromUsePackage {
      package = pkgs.emacs-git-pgtk;  # replace with pkgs.emacsGit, or another version if desired.
      config = /home/jonah/.config/doom/config.el;
      # config = path/to/your/config.org; # Org-Babel configs also supported

      # Optionally provide extra packages not in the configuration file.
      # extraEmacsPackages = epkgs: [
      #     epkgs.use-package;
      # ];

      # Optionally override derivations.
      # override = epkgs: epkgs // {
      #     somePackage = epkgs.melpaPackages.somePackage.overrideAttrs(old: {
      #     # Apply fixes here
      #     });
      # };
      })
  ];
}