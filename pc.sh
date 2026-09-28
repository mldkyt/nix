# RUN USING bash update.sh

sudo cp -r modules/ flake.nix /etc/nixos
sudo nixos-rebuild switch --flake /etc/nixos#mldkyt-pc --show-trace
