#!/run/current-system/sw/bin/sh

sudo echo "Rebuilding system 🗿"

if [ "$1" != "-s" ]; then
    sudo echo "removing *.nixbak files"
    sudo find ~/ -name "*.nixbak" -type f -delete
fi

sudo nixos-rebuild switch --flake .#thinkpad-l15

./common-rebuild-commands.sh "Thinkpad-L15"
