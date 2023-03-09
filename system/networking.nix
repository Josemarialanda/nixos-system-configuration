{ config, pkgs,... }:
{
  config.networking = {
    # Setup networking.
    networkmanager.enable = true;
    hostName = "nixos";
  };
}