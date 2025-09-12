# RUN USING bash update.sh

cd /etc/nixos

sudo rm flake.lock
sudo nix flake update --refresh
