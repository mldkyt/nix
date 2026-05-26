{
  pkgs,
  lib,
  ...
}:

pkgs.python312Packages.buildPythonApplication rec {
  pname = "mcstatus1";
  rev = "c5330d5c1f7ad87c8c86488f981c213ce65f9dfe";
  version = "1.0.0+${rev}";

  src = "${pkgs.fetchFromGitea {
    inherit rev;
    domain = "git.lunya.pet";
    owner = "lunya";
    repo = "mcweb";
    sha256 = "9RFGAeAuNAvK8igD1kHU0QrQy6VPJ+L2izhfbJDJS+A=";
  }}/mcstatus1";

  propagatedBuildInputs = with pkgs.python312Packages; [
    mcstatus
    psycopg2
    sqlalchemy
  ];

  preBuild = ''
    cat > setup.py << EOF
from setuptools import setup

setup(
  name="mcstatus1",
  version="1.0",
  scripts=["main.py"],
)
EOF
  '';

  pyproject = true;
  build-system = with pkgs.python312Packages; [ setuptools ];
  format = "pyproject";

  meta = {
    inherit pname version;
    description = "Minecraft server tracker";
    maintainers = with lib.maintainers; [
      lunya
    ];
  };
}
