{
  stdenv,
  fetchFromGitea,
  lib,
  ...
}:

stdenv.mkDerivation rec {
  name = "website";
  rev = "710166f3b958e2d907564d2634ccb66117f7bb95";

  src = fetchFromGitea {
    inherit rev;
    domain = "git.lunya.pet";
    owner = "lunya";
    repo = "website";
    sha256 = "sha256-Tcl/sSIZEzFKxpCKHf3WpxkuXgJTHDuLb86UtjfwjB0=";
  };

  dontBuild = true;

  installPhase = ''
    runHook preInstall

    mkdir -p $out
    cp -r $src/src/* $out

    runHook postInstall
  '';

  meta = {
    pname = "website";
    version = "${rev}";
    maintainers = [
      lib.maintainers.lunya
    ];
  };
}
