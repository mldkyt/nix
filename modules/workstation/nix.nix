{
  pkgs,
  ...
}:

{
  nix.package = pkgs.lixPackageSets.stable.lix;
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Trusted users
  nix.settings.trusted-users = [
    "root"
    "lunya"
  ];
}
