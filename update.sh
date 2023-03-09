flag=$1

if [ $flag = "boot" ]; then
  nixos-rebuild boot --impure --flake .#
elif [ $flag = "switch" ]; then
  nixos-rebuild switch --impure --flake .#
elif [ $flag = "build" ]; then
  nixos-rebuild build --impure --flake .#
else
  echo "Options are boot, switch or build."
fi