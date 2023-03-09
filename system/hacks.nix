{ config, pkgs,... }:

let 
  config-variables = import ../config-variables.nix;
  monitorsXmlContent = builtins.readFile "/home/${config-variables.username}/.config/monitors.xml";
  monitorsConfig = pkgs.writeText "gdm_monitors.xml" monitorsXmlContent;
in {
  config = {
  # Make GDM follow desktop monitor config. (uses user set refresh rate)
  systemd.tmpfiles.rules = [ "L+ /run/gdm/.config/monitors.xml - - - - ${monitorsConfig}" ];

  # Prevent ugreen usb hub from waking pc from sleep.
  services.udev.extraRules = ''
    ACTION=="add", ATTRS{idVendor}=="05e3", ATTRS{idProduct}=="0610", ATTR{power/wakeup}="disabled"
    ACTION=="add", ATTRS{idVendor}=="05e3", ATTRS{idProduct}=="0626", ATTR{power/wakeup}="disabled"
  '';
  };
}