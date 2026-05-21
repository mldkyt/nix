
sudo cp -r modules/ flake.nix /etc/nixos
sudo nixos-rebuild switch --flake /etc/nixos#lunya-server  --show-trace
