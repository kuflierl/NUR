# This file describes your repository contents.
# It should return a set of nix derivations
# and optionally the special attributes `lib`, `modules` and `overlays`.
# It should NOT import <nixpkgs>. Instead, you should take pkgs as an argument.
# Having pkgs default to <nixpkgs> is fine though, and it lets you use short
# commands such as:
#     nix-build -A mypackage

{ pkgs ? import <nixpkgs> { } }:
let
  # The `lib`, `modules`, and `overlays` names are special
  lib = import ./lib { inherit pkgs; }; # functions
  modules = import ./modules; # NixOS modules
  overlays = import ./overlays; # nixpkgs overlays
  
  callPackage = pkgs.lib.callPackageWith (pkgs // { customLib = lib; } // packages);
  packages = {
    example-package = callPackage (lib.pkgPathByName "example-package") { };
    intel-oneapi-dpcpp-cpp = callPackage (lib.pkgPathByName "intel-oneapi-dpcpp-cpp") { };
    level-zero-1-19 = callPackage (lib.pkgPathByName "level-zero-1-19") { };
    intel-compute-runtime-24-39-31294-12 = callPackage (lib.pkgPathByName "intel-compute-runtime-24-39-31294-12") { };
    oneapi-unified-memory-framework = callPackage (lib.pkgPathByName "oneapi-unified-memory-framework") { };
  };
in
packages // {inherit modules overlays lib;}
