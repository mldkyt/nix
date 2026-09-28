{
  pkgs,
  ...
}:

{
  programs.git = {
    enable = true;
    lfs.enable = true;
    package = pkgs.gitFull;
    settings = {
      init = {
        defaultBranch = "main";
      };
      user = {
        name = "mldkyt";
        email = "mldkyt@mldkyt.com";
        signingKey = "B60E07AE854F3F09"; # needs import
      };
      tag.gpgSign = true;
      commit.gpgSign = true;
      credential.helper = "libsecret";
    };
  };
}
