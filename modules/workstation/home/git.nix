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
        name = "Lunya";
        email = "lunya@murena.io";
        signingKey = "458591AD4C4C0233"; # needs import
      };
      tag.gpgSign = true;
      commit.gpgSign = true;
      credential.helper = "libsecret";
    };
  };
}
