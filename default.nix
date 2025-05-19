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
    example-package = callPackage ./pkgs/by-name/ex/example-package/package.nix { };
    intel-oneapi-dpcpp-cpp = callPackage ./pkgs/by-name/in/intel-oneapi-dpcpp-cpp/package.nix { };
    level-zero-1-19 = callPackage ./pkgs/by-name/le/level-zero-1-19/package.nix { };
    intel-compute-runtime-24-39-31294-12 = callPackage ./pkgs/by-name/in/intel-compute-runtime-24-39-31294-12/package.nix { };
    oneapi-unified-memory-framework = callPackage ./pkgs/by-name/on/oneapi-unified-memory-framework/package.nix { };
  };
in
packages // {inherit modules overlays lib;}
