{
  ...
}:

{
  programs.virt-manager.enable = true;
  users.groups.libvirtd.members = [ "lunya" ];
  virtualisation.libvirtd.enable = true;
  virtualisation.spiceUSBRedirection.enable = true;
}
