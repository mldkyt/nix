{
  ...
}:

{
  virtualisation.podman = {
    enable = true;
    dockerCompat = true;
    dockerSocket.enable = true;
  };

  virtualisation.containers.registries.search = [
    "docker.io"
    "quay.io"
    "ghcr.io"
  ];

  virtualisation.oci-containers.backend = "podman";
}
