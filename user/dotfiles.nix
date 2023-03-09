{ config, pkgs, ... }:
{
  # Dracula color scheme for tilix.
  home.file.".config/tilix/schemes/Dracula.json".source = ./themes/tilix/Dracula.json;

  # Dracula color scheme for kakoune.
  home.file.".config/kak/colors/dracula.kak".source = ./themes/kakoune/dracula.kak;
}