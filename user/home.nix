{ config, pkgs, ... }:
let 
  config-variables = import ../config-variables.nix;
in {
  programs.home-manager.enable = true;
  home.username = config-variables.username;
  home.homeDirectory = "/home/" + config-variables.username;
  home.stateVersion = config-variables.stateVersion;

  imports = [
    ./programs.nix
    ./dotfiles.nix
  ];
  }