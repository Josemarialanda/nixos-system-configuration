{ config, pkgs, ... }:
{
  programs.home-manager.enable = true;
  home.username = "josemaria";
  home.homeDirectory = "/home/josemaria";
  home.stateVersion = "22.11";

  imports = [
    ./programs.nix
    ./dotfiles.nix
  ];
  }