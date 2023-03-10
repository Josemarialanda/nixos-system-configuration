flag=$1

if [ $flag = "boot" ]; then
  sudo nixos-rebuild boot --impure --flake .#
elif [ $flag = "switch" ]; then
  sudo nixos-rebuild switch --impure --flake .#
elif [ $flag = "build" ]; then
  sudo nixos-rebuild build --impure --flake .#
else
  echo "Options are boot, switch or build."
fi