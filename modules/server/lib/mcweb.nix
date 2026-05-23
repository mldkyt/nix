{
  stdenv,
  fetchFromGitea,
  lib,
  ...
}:

stdenv.mkDerivation rec {
  name = "mcweb";
  rev = "c5330d5c1f7ad87c8c86488f981c213ce65f9dfe";

  src = fetchFromGitea {
    inherit rev;
    domain = "git.lunya.pet";
    owner = "lunya";
    repo = "mcweb";
    sha256 = lib.fakeSha256;
  };

  dontBuild = true;

  installPhase = ''
    runHook preInstall

    mkdir $out
    cp -r $src/website/* $out

    runHook postInstall
  '';

  meta = {
    pname = "${name}";
    version = "1.0.0+${rev}";
    maintainers = [
      lib.maintainers.lunya
    ];
  };
}
