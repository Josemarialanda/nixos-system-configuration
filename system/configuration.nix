{ config, pkgs, ... }:

{
  system.stateVersion = "22.11";

  imports =
    [ ./hardware-configuration.nix
      ./hacks.nix
      ./fonts.nix
      ./devices.nix
      ./common.nix
      ./networking.nix
      ./region.nix
      ./sound.nix
      ./services.nix
      ./nix-settings.nix
      ./users.nix
      ./asus-b550-rog-strix-f-gaming.nix
      ./display.nix
    ];
}
