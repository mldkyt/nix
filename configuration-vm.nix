{ config, pkgs, ... }:

{
  imports = [
    ./configuration.nix
  ];

  networking.hostName = "lunya-vm";
  
}
