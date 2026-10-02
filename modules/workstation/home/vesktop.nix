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
          YoutubeAdblock.enabled = true;
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
          Dearrow.enabled = true;
          Decor.enabled = true;
          DisableCallIdle.enabled = true;
          FavoriteEmojiFirst.enabled = true;
          FavoriteGifSearch.enabled = true;
          FriendInvites.enabled = true;
          ImageFilename.enabled = true;
          ImplicitRelationships.enabled = true;
          MemberCount.enabled = true;
          MessageLinkEmbeds.enabled = true;
          LoadingQuotes.enabled = true;
          NewGuildSettings = {
            enabled = true;
            messages = "mentions";
          };
          NoBlockedMessages.enabled = true;
          NoMiddleClickPaste.enabled = true;
          NoOnboardingDelay.enabled = true;
          NoProfileThemes.enabled = true;
          NoTypingAnimation.enabled = true;
          NoUnblockToJump.enabled = true;
          oneko.enabled = true;
          OnePingPerDM.enabled = true;
          OpenInApp.enabled = true;
          petpet.enabled = true;
          PinDMs.enabled = true;
          PlatformIndicators.enabled = true;
          ReactErrorDecoder.enabled = true;
          ReadAllNotificationsButton.enabled = true;
          ReplaceGoogleSearch = {
            enabled = true;
            customEngineName = "DuckDuckGo";
            customEngineURL = "https://duckduckgo.com/search?q=";
          };
          ReplyTimestamp.enabled = true;
          ReviewDB.enabled = true;
          ShikiCodeblocks.enabled = true;
          SpotifyCrack.enabled = true;
          SilentTyping.enabled = true;
          TypingTweaks.enabled = true;
          TypingIndicator.enabled = true;
          UserMessagesPronouns.enabled = true; # wokeness
          ValidReply.enabled = true;
          ValidUser.enabled = true;
          VoiceDownload.enabled = true;
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
          ShowMeYourName = {
            enabled = true;
            mode = "nick-user";
          };
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
          MessageClickActions.enabled = true;
          QuickReply.enabled = true;
        };
      };
    };
  };

  services.arrpc = {
    enable = true;
    systemdTarget = "graphical-session.target";
  };
}
