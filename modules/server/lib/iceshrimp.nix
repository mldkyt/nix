# https://git.gay/sugar/nix-config/src/branch/master/packages/iceshrimp-net/default.nix#


{
  lib,
  buildDotnetModule,
  fetchFromGitea,
  dotnetCorePackages,
  vips,
}:
let
  rev = "611d31e89e3a876c5fe43272e91bb20758a401cc";
in
buildDotnetModule {
  pname = "iceshrimp.net";
  version = "2026.1.1-beta+${rev}";
  src = fetchFromGitea {
    domain = "git.lunya.pet";
    owner = "lunya";
    repo = "Iceshrimp.NET";
    inherit rev;
    forceFetchGit = true;
    sha256 = "sha256-lmqXtAZ/4cahER7h+WlSPCT1vTOMUHbqh8/+FuimJa8=";
  };
  dotnet-sdk = dotnetCorePackages.sdk_10_0;
  dotnet-runtime = dotnetCorePackages.aspnetcore_10_0;
  nugetDeps = ./deps_iceshrimp.json;
  useAppHost = false;
  selfContainedBuild = null;
  projectFile = "Iceshrimp.Backend/Iceshrimp.Backend.csproj";
  # Work around https://github.com/dotnet/runtime/issues/110624
  preConfigure = ''
    dotnet() {
      args=()
      runtime=
      for arg in "$@"
      do
        if test "$runtime"
        then
          args+=("-p" "RuntimeIdentifier=$arg")
          runtime=
        elif test "$arg" = --runtime
        then
          runtime=1
        else
          args+=($arg)
        fi
      done
      command dotnet "''${args[@]}"
    }
  '';
  makeWrapperArgs = [
    "--prefix"
    "LD_LIBRARY_PATH"
    ":"
    "${lib.makeLibraryPath [ vips ]}"
  ];
}
