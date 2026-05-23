{
  stdenv,
  fetchGitea,
  lib,
  ...
}:

stdenv.mkDerivation rec {
  rev = "710166f3b958e2d907564d2634ccb66117f7bb95";

  src = fetchGitea {
    inherit rev;
    instance = "git.lunya.pet";
    owner = "lunya";
    repo = "website";
    sha256 = lib.fakeSha256;
  };

  dontBuild = true;

  installPhase = ''
    runHook preInstall

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
