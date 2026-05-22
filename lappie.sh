# RUN USING bash update.sh

sudo cp -r secrets/ modules/ flake.nix /etc/nixos
sudo nixos-rebuild switch --flake /etc/nixos#lunya-lappie  --show-trace
