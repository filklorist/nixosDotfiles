{ pkgs ? import <nixpkgs> {} }:
pkgs.callPackage ./derivation-old.nix {}
