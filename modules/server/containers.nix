{...}:

{

  networking.nat = {
    enable = true;
    enableIPv6 = true;

    internalInterfaces = [ "ve-+" ];
    externalInterface = "enp1s0";
  };

  virtualisation = {
    podman = {
      enable = true;
      dockerCompat = true;
      dockerSocket.enable = true;
    };
    oci-containers.backend = "podman";
  };

}
