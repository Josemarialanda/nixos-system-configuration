{ config, pkgs,... }:
{
  config.nix.settings = {
    # Automatic nix store storage optimization.
    auto-optimise-store = true;
  };
}