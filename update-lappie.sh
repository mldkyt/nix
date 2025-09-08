# RUN USING bash update.sh

sudo cp configuration{,-lappie}.nix flake.nix /etc/nixos
sudo nixos-rebuild switch --flake /etc/nixos#lunya-lappie
