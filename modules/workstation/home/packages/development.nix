{
  pkgs,
  ...
}:

{
  home.packages = with pkgs; [
    devenv
    sqlitebrowser
    jetbrains.rider
    kdePackages.kate
  ];
}
