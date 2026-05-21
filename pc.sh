# RUN USING bash update.sh

sudo cp -r modules/ flake.nix /etc/nixos
sudo nixos-rebuild switch --flake /etc/nixos#lunya-pc --show-trace
