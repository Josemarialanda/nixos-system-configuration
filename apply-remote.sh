wget https://github.com/Josemarialanda/nixos-system-configuration/archive/master.tar.gz
tar -xf master.tar.gz
pushd nixos-system-configuration-master
./update-system.sh "boot"
./update-home.sh
popd
rm -r nixos-system-configuration-master
echo "Reboot computer for changes to take effect"