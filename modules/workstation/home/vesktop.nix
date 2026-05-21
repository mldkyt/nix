{
  ...
}:
{
  programs.vesktop = {
    enable = true;
    settings = {
      tray = true;
      minimizeToTray = true;
      hardwareAcceleration = true;
      hardwareVideoAcceleration = true;
      customTitleBar = true;
      staticTitle = true;
      notifyAboutUpdates = true;
      discordBranch = "ptb";
    };

    vencord = {
      extraQuickCss = ''
        @import url("https://catppuccin.github.io/discord/dist/catppuccin-mocha-mauve.theme.css");
      '';

      settings = {
        autoUpdate = true;
        autoUpdateNotification = true;
        notifyAboutUpdates = true;
        useQuickCss = true;
        plugins = {
          ArRPC.enabled = true;
          ClearURLs.enabled = true;
          FixYoutubeEmbeds.enabled = true;
          MessageLogger = {
            enabled = true;
            ignoreSelf = true;
          };
          AnonymiseFileNames.enabled = true;
          RelationshipNotifier.enabled = {
            enabled = true;
          };
          BetterSessions.enabled = true;
          BetterGifPicker.enabled = true;
          BetterUploadButton.enabled = true;
          BlurNSFW.enabled = true;
          CallTimer.enabled = true;
          ColorSighted.enabled = true;
          MessageLatency.enabled = true;
          CrashHandler = {
            enabled = true;
            attemptToPreventCrashes = true;
            attemptToNavigateToHome = true;
          };
          WebScreenShareFixes.enabled = true;
          WebKeybinds.enabled = false;
          DontRoundMyTimestamps.enabled = true;
          BetterSettings = {
            enabled = true;
            disableFade = true;
            organizeMenu = true;
            eagerLoad = true;
          };
          CustomIdle = {
            enabled = true;
            idleTimeout = 10;
            remainInIdle = false;
          };
          NoTypingAnimation.enable = true;
          ShowMeYourName.enabled = true;
          ServerInfo.enabled = true;
          PermissionsViewer.enabled = true;
          VoiceChatDoubleClick.enabled = true;
          NoTrack.enabled = true;
          MutualGroupDMs.enabled = true;
          MoreQuickReactions.enabled = true;
          KeepCurrentChannel.enabled = true;
          ShowHiddenChannels.enabled = true;
          ShowTimeoutDuration.enabled = true;
          FakeNitro.enabled = true;
          NoPendingCount.enabled = true;
        };
      };
    };
  };

  services.arrpc = {
    enable = true;
    systemdTarget = "graphical-session.target";
  };
}
