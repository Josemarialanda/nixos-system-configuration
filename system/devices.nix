{ config, pkgs,... }:
{
  config.hardware = {
    # Enable Logitech wireless devices.
    logitech.wireless.enable = true;
    logitech.wireless.enableGraphical = true;
    
    # Enable udev rules for Ledger devices.
    ledger.enable = true;
  };
}