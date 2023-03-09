{ config, pkgs,... }:
let 
  config-variables = import ../config-variables.nix;
in {
  config.networking = {
    # Setup networking.
    networkmanager.enable = true;
    hostName = config-variables.hostname;
  };
}