{
  ...
}:

{

  programs.zed-editor = {
    enable = true;
    extensions = ["nix" "toml" "rust" "catppuccin" "catppuccin-icons" "emmet"];
    userSettings = {
      telemetry = {
        diagnostics = false;
        metrics = false;
      };
      disable_ai = true;
      languages."Nix".language_servers = ["!nil" "nixd"];
      project_panel.dock = "left";
      git_panel.dock = "left";
      collaboration_panel.button = false;
      theme = "Catppuccin Mocha";
      icon_theme = "Catppuccin Mocha";
    };
  };
}
