
sudo cp -r secrets/ modules/ common.nix flake.nix /etc/nixos
sudo nixos-rebuild switch --flake /etc/nixos#lunya-server  --show-trace
