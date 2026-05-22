
{pkgs, ...}:

{
  # Git for pulling configuration files to server
  programs.git = {
    enable = true;
    lfs.enable = true;
    package = pkgs.gitFull;
  };
}
