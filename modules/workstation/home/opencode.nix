{ pkgs, ... }:
let
  caveman = pkgs.fetchFromGitHub {
    owner = "JuliusBrussee";
    repo = "caveman";
    rev = "main";
    hash = "sha256-KFfU8LmNajKLZcOXOFisn4beTcg2YL+rpasr39UgSZE=";
  };
in
{
  programs.opencode = {
    enable = true;

    skills = {
      caveman = "${caveman}/skills/caveman";
      caveman-compress = "${caveman}/skills/caveman-compress";
    };
  };

  catppuccin.opencode = {
    enable = true;
    flavor = "mocha";
  };

  xdg.configFile."opencode/AGENTS.md".text = ''
    Use the **caveman** skill by default.
    Respond in full caveman mode unless the user says "stop caveman" or "normal mode".
  '';
}
