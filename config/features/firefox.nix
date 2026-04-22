{ config, lib, pkgs, ... }:

{
  options.features.firefox.enable = lib.mkEnableOption "Firefox preconfig";

  config = lib.mkIf config.features.firefox.enable {
    programs.firefox = {
      enable = true;
      languagePacks = [ "fr" ];
      policies = {
        DisableAppUpdate = true;
        DisablePocket = true;
        DisableTelemetry = true;
        DisplayBookmarksToolbar = "newtab";
        DisplayMenuBar = "default-off";
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
        HttpsOnlyMode = "enabled";
        
        # Disable adding a shortcut to the Nixos manual in the Firefox bookmarks.
        NoDefaultBookmarks = true;
        
        # Disable password saving
        OfferToSaveLogins = false;
        OfferToSaveLoginsDefault = false;
        PasswordManagerEnabled = false;
        
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
          "privacy.globalprivacycontrol.enabled" = {
            Value = true;
            Status = "locked";
          };
        };
        
        PrintingEnabled = true;
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
