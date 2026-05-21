{
  ...
}:

{
  # TODO replace zed-editor package with gram-editor
  programs.zed-editor = {
    enable = true;
    extensions = ["nix" "toml" "rust"];
    userSettings = {
      telemetry = {
        diagnostics = false;
        metrics = false;
      };
      disable_ai = true;
      languages."Nix".language_servers = ["!nil" "nixd"];
    };
    mutableUserSettings = true;
    mutableUserKeymaps = true;
    mutableUserTasks = true;
    mutableUserDebug = true;
  };
}
