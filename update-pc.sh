# RUN USING bash update.sh

sudo cp configuration{,-pc}.nix flake.nix /etc/nixos
sudo nixos-rebuild switch --flake /etc/nixos#lunya-pc
