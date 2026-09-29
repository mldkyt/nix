{
  pkgs,
  ...
}:

{

  programs.zed-editor = {
    enable = true;
    extensions = [
      "nix"
      "toml"
      "rust"
      "php"
      "catppuccin"
      "catppuccin-icons"
      "emmet"
      "discord-presence"
      "git-firefly"
      "prisma"
    ];
    extraPackages = with pkgs; [
      nixd
      nixfmt
    ];
    userSettings = {
      telemetry = {
        diagnostics = false;
        metrics = false;
      };
      disable_ai = true;
      languages."Nix" = {
        language_servers = [
          "!nil"
          "nixd"
        ];
        formatter.external = {
          command = "nixfmt";
          arguments = [ ];
        };
      };
      lsp.nixd = {
        binary.path_lookup = true;

        settings = {
          formatting.command = [ "nixfmt" ];
        };
      };
      project_panel.dock = "left";
      git_panel.dock = "left";
      collaboration_panel.button = false;
      theme = "Catppuccin Mocha";
      icon_theme = "Catppuccin Mocha";
      format_on_save = "on";
    };
  };
}
