{ config, pkgs, ... }:

{
  imports = [
    ../../common.nix
  ];
  networking.hostName = "lunya-server";
}
