{
  pkgs,
  ...
}:

{

  programs.firefox = {
    enable = true;

    profiles = {
      default = {
        id = 0;
        name = "default";
        isDefault = true;

        extensions.packages = with pkgs.nur.repos.rycee.firefox-addons; [
          ublock-origin-upstream
          enhancer-for-youtube
          bypass-paywalls-clean
          firefox-color
          bitwarden
          clearurls
          privacy-badger
          youtube-nonstop
          consent-o-matic
          tab-reloader
          sponsorblock
          dearrow
        ];
        extensions.force = true;

        settings = {
          "browser.ml.enable" = false;
          "browser.ai.control.default" = "blocked";
          "browser.ai.control.sidebarChatbot" = "blocked";
          "browser.ml.chat.enabled" = false;
          "browser.ml.chat.sidebar" = false;
          "browser.ml.chat.menu" = false;
          "browser.ml.chat.page" = false;
          "extensions.ml.enabled" = false;
          "browser.ai.control.linkPreviewKeyPoints" = "blocked";
          "browser.ml.linkPreview.enabled" = false;
          "browser.ml.pageAssist.enabled" = false;
          "browser.ml.smartAssist.enabled" = false;
          "browser.ai.control.smartTabGroups" = "blocked";
          "browser.tabs.groups.smart.enabled" = false;
          "browser.tabs.groups.smart.userEnabled" = false;
          "browser.ai.control.translations" = "blocked";
          "browser.ai.control.pdfjsAltText" = "blocked";
          "pdfjs.enableAltTextModelDownload" = false;
          "pdfjs.enableGuessAltText" = false;

          "browser.translations.enable" = false;
          "identity.fxaccounts.enabled" = false;
          "sidebar.revamp" = false;
          "sidebar.visibility" = "hide-sidebar";
          "browser.discovery.enabled" = false;
          "signon.rememberSignons" = false;

          "toolkit.telemetry.enabled" = false;
          "toolkit.telemetry.unified" = false;
          "toolkit.telemetry.archive.enabled" = false;
          "toolkit.telemetry.bhrPing.enabled" = false;
          "toolkit.telemetry.firstShutdownPing.enabled" = false;
          "toolkit.telemetry.newProfilePing.enabled" = false;
          "toolkit.telemetry.shutdownPingSender.enabled" = false;
          "toolkit.telemetry.updatePing.enabled" = false;
          "browser.ping-centre.telemetry" = false;
          "extensions.autoDisableScopes" = 0;
        };
      };
    };
  };

  catppuccin.firefox.profiles.default.enable = true;

}
