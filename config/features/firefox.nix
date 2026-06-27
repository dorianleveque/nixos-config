{ config, lib, pkgs, ... }:

{
  options.features.firefox.enable = lib.mkEnableOption "Firefox preconfig";

  config = lib.mkIf config.features.firefox.enable {
    programs.firefox = {
      enable = true;
      languagePacks = [ "fr" ];
      policies = {
        # Disable auto update (update are controlled by nix)
        DisableAppUpdate = true;
        
        # Disable adding a shortcut to the Nixos manual in the Firefox bookmarks.
        NoDefaultBookmarks = true;

        # Remove useless pocket
        DisablePocket = true;

        # Remove ads & tracking
        DisableTelemetry = true;
        EnableTrackingProtection = {
          Locked = true;
          Category = "strict";
          Cryptomining = true;
          EmailTracking = true;
          Fingerprinting = true;
          SuspectedFingerprinting = true;
          Value= true;
        };
        ExtensionSettings = {
          "firefox@ghostery.com" = {
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/ghostery/latest.xpi";
              installation_mode = "force_installed";
              default_area = "menupanel";
              private_browsing = true;
              updates_disabled = false;
          };
          "{a218c3db-51ef-4170-804b-eb053fc9a2cd}" = {
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/qr-code-address-bar/latest.xpi";
            installation_mode = "force_installed";
            default_area = "navbar";
            private_browsing = true;
            updates_disabled = false;
          };
        };
        FirefoxHome = {
          Highlights = false;
          Locked = false;
          Pocket = false;
          Search = true;
          Snippets = false;
          SponsoredTopSites = false;
          SponsoredPocket = false;
          SponsoredStories = false;
          Stories = false;
          TopSites = true;
        };

        # Do not allow users to compromise their own security
        DisableSecurityBypass = {
          InvalidCertificate = false;
          SafeBrowsing = false;
        };
        HttpsOnlyMode = "force_enabled";
        
        # Disable password saving
        DisablePasswordReveal = false;
        OfferToSaveLogins = false;
        OfferToSaveLoginsDefault = false;
        PasswordManagerEnabled = false;

        # Disable auto fill
        AutofillAddressEnabled = false;
        AutofillCreditCardEnabled = false;

        # Allow printing
        PrintingEnabled = true;
        
        # Force pip in Firefox with picture gnome extension
        PictureInPicture = {
          Enabled = true;
          Locked = true;
        };
        
        Preferences = {
          "browser.display.document_color_use" = {
            Value = 0;
            Status = "locked"; # put "default" if gnome settings enabled (flake)
          };

          # Put the video in picture in picture (pip) mode when user switch to another tab.
          "media.videocontrols.picture-in-picture.enable-when-switching-tabs.enabled" = {
            "Value" = true;
            "Status" = "default";
          };

          "privacy.globalprivacycontrol.enabled" = {
            Value = true;
            Status = "locked";
          };
        };

        # Look & feel
        DisplayBookmarksToolbar = "newtab";
        DisplayMenuBar = "default-off";
        RequestedLocales = "fr";
        SearchBar = "unified";
        SearchEngines = {
          Default = "Google";
          Remove = ["Bing" "eBay"];
        };
        ShowHomeButton = false;
        TranslateEnabled = true;
      };
    };
  };
}
