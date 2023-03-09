{ config, pkgs,... }:
{
  config = {
    # System fonts.
    fonts.fonts = with pkgs ; [
      fira-code
      cascadia-code
    ];
  };
}