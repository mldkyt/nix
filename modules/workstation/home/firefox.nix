{
  ...
}:

{

  programs.firefox = {
    enable = true;

    policies = {
      # Telemetry / studies / pocket / accounts
      DisableTelemetry = true;
      DisableFirefoxStudies = true;
      DisablePocket = true;
      DisableFirefoxAccounts = true;
      DisableAccounts = true;
      DisableFeedbackCommands = true;
      DisableFirefoxScreenshots = true;

      FirefoxHome = {
        Search = true;
        TopSites = false;
        SponsoredTopSites = false;
        Highlights = false;
        Pocket = false;
        SponsoredPocket = false;
        Snippets = false;
        Locked = true;
      };

      FirefoxSuggest = {
        WebSuggestions = false;
        SponsoredSuggestions = false;
        ImproveSuggest = false;
      };

      UserMessaging = {
        ExtensionRecommendations = false;
        FeatureRecommendations = false;
        UrlbarInterventions = false;
        SkipOnboarding = true;
        MoreFromMozilla = false;
        FirefoxLabs = false;
      };

      PasswordManagerEnabled = false;

      # Extensions + theme
      ExtensionSettings = {
        # Default: block everything else
        "*" = {
          installation_mode = "blocked";
          blocked_install_message = "Extension installation is managed by your Nix config.";
          allowed_types = [
            "extension"
            "theme"
          ];
        };

        # --- Your previous extensions ---
        "uBlock0@raymondhill.net" = {
          # ublock-origin
          installation_mode = "force_installed";
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
        };

        "enhancerforyoutube@maximerf.addons.mozilla.org" = {
          # enhancer-for-youtube
          installation_mode = "force_installed";
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/enhancer-for-youtube/latest.xpi";
        };

        "{446900e4-71c2-419f-a6a7-df9c091e268b}" = {
          # bitwarden
          installation_mode = "force_installed";
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/bitwarden-password-manager/latest.xpi";
        };

        "{74145f27-f039-47ce-a470-9e1c5921623f}" = {
          # clearurls
          installation_mode = "force_installed";
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/clearurls/latest.xpi";
        };

        "jid1-MnnxcxisBPnSXQ@jetpack" = {
          # privacy-badger
          installation_mode = "force_installed";
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/privacy-badger17/latest.xpi";
        };

        "{0d7cafdd-501c-49ca-8ebb-e3341caaa55e}" = {
          # youtube-nonstop
          installation_mode = "force_installed";
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/youtube-nonstop/latest.xpi";
        };

        "gdpr@cavi.au.dk" = {
          # consent-o-matic
          installation_mode = "force_installed";
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/consent-o-matic/latest.xpi";
        };

        "tabreloader@webextension.org" = {
          # tab-reloader
          installation_mode = "force_installed";
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/tab-reloader/latest.xpi";
        };

        "sponsorBlocker@ajay.app" = {
          # sponsorblock
          installation_mode = "force_installed";
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/sponsorblock/latest.xpi";
        };

        "deArrow@ajay.app" = {
          # dearrow
          installation_mode = "force_installed";
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/dearrow/latest.xpi";
        };

        # --- Theme ---
        "{4803bab0-01c6-4fee-8947-d23f7c233cc4}" = {
          # dark-trans-pride-theme
          installation_mode = "force_installed";
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/dark-trans-pride-theme/latest.xpi";
        };
      };
    };

    profiles.default = {
      id = 0;
      name = "default";
      isDefault = true;

      extensions.force = true;

      settings = {
        # AI / ML features
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

        # Sidebar / discovery / accounts (from your original)
        "sidebar.revamp" = false;
        "sidebar.visibility" = "hide-sidebar";
        "browser.discovery.enabled" = false;
        "identity.fxaccounts.enabled" = false;

        # Password manager
        "signon.rememberSignons" = false;

        # Telemetry (policies already cover most of this, but keep the prefs)
        "toolkit.telemetry.enabled" = false;
        "toolkit.telemetry.unified" = false;
        "toolkit.telemetry.archive.enabled" = false;
        "toolkit.telemetry.bhrPing.enabled" = false;
        "toolkit.telemetry.firstShutdownPing.enabled" = false;
        "toolkit.telemetry.newProfilePing.enabled" = false;
        "toolkit.telemetry.shutdownPingSender.enabled" = false;
        "toolkit.telemetry.updatePing.enabled" = false;
        "browser.ping-centre.telemetry" = false;
        "datareporting.healthreport.uploadEnabled" = false;
        "datareporting.policy.dataSubmissionEnabled" = false;

        # Sponsored / new-tab extras
        "browser.newtabpage.activity-stream.showSponsored" = false;
        "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
        "browser.newtabpage.activity-stream.system.showSponsored" = false;
        "browser.topsites.contile.enabled" = false;
        "browser.newtabpage.activity-stream.feeds.section.topstories" = false;
        "browser.newtabpage.activity-stream.section.highlights.includePocket" = false;
        "extensions.pocket.enabled" = false;

        # Make sure extensions can be installed by policy
        "extensions.autoDisableScopes" = 0;

        # Force the dark-trans-pride theme as the active theme
        "extensions.webextensions.themes.active" = "{4803bab0-01c6-4fee-8947-d23f7c233cc4}";
        "extensions.webextensions.themes.current" = "{4803bab0-01c6-4fee-8947-d23f7c233cc4}";
      };
    };
  };
}
