{
  ...
}:

{
  nixpkgs.config = {
    allowUnfree = true;
  };

  nix.settings.trusted-users = [
    "root"
    "lunya"
  ];

  nix.gc = {
    automatic = true;
    options = "--delete-older-than 3d";
  };
}
