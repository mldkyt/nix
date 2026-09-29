{
  ...
}:

{

  programs.plasma = {
    enable = true;

    workspace = {
      lookAndFeel = "catppuccin-mocha-mauve";
      colorScheme = "CatppuccinMochaMauve";
      iconTheme = "Papirus-Dark";
      cursor = {
        cursorFeedback = "None";
      };
    };
    fonts = {
      general = {
        family = "Adwaita Sans";
        pointSize = 10;
      };
    };
    input = {
      keyboard = {
        repeatDelay = 300;
        repeatRate = 50;
        numlockOnStartup = "on";
        layouts = [
          {
            layout = "cz";
          }
          {
            layout = "us";
          }
        ];
      };
    };
    configFile."kdeglobals" = {
      "KDE"."AnimationDurationFactor" = "0.5";
    };
    configFile."spectaclerc" = {
      "General" = {
        "autoSaveImage" = "true";
        "clipboardGroup" = "PostScreenshotCopyImage";
      };
    };
    configFile."kglobalshortcutsrc" = {
      "KDE Keyboard Layout Switcher" = {
        "Switch to Next Keyboard Layout" = "Meta+Space,Meta+Alt+K,Switch to Next Keyboard Layout";
      };
    };
  };
}
