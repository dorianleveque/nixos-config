{ username ? "dorian", config, lib, pkgs, ... }:

{
  #home.activation = {
  #	updateLocalDesktopDatabase = lib.hm.dag.entryAfter ["writeBoundary"] ''
  #	  run update-desktop-database $HOME/.local/share/applications
  #	'';
  #};

  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = username;
  home.homeDirectory = "/home/${username}";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "25.05"; # Please read the comment before changing.

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    dconf-editor
    dconf2nix
    desktop-file-utils
    discord
    gnome-tweaks
    gnome-secrets
    #gnomeExtensions.blur-my-shell
    #gnomeExtensions.caffeine
    #gnomeExtensions.dash-to-panel
    #gnomeExtensions.gsconnect
    #gnomeExtensions.night-theme-switcher
    #gnomeExtensions.printers
    #gnomeExtensions.remove-world-clocks
    #gnomeExtensions.night-theme-switcher
    nodejs
    micro
    parabolic
    shortwave
    steam
    tagger
    thunderbird
    upscaler
    video-downloader
    vscode
    wget
    zip
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/dorian/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  dconf.settings = {
	/*"org/gnome/desktop/privacy" = {
	  old-files-age = uint32 30;
	  remove-old-temp-files = true;
	  remove-old-trash-files = true;
	};*/
  
    "org/gnome/desktop/calendar".show-weekdate = true;
    "org/gnome/desktop/interface".clock-show-weekday = true;
    "org/gnome/desktop/interface".locate-pointer = true;
    "org/gnome/desktop/input-sources".xkb-options = ["terminate:ctrl_alt_bksp" "compose:rctrl"];
    
    "org/gnome/desktop/peripherals/mouse".natural-scroll = false;
    "org/gnome/desktop/wm/preferences".action-double-click-titlebar = "toggle-maximize";
    "org/gnome/desktop/wm/preferences".action-middle-click-titlebar = "none";
    "org/gnome/desktop/wm/preferences".action-right-click-titlebar = "menu";
    "org/gnome/desktop/wm/preferences".button-layout = "appmenu:minimize,maximize,close"; 
    # "org/gnome/desktop/wm/preferences".focus-mode = "sloppy";
    "org/gnome/desktop/wm/preferences".mouse-button-modifier = "<Super>";
    "org/gnome/mutter".attach-modal-dialogs = true;
    "org/gnome/mutter".center-new-windows = true;
    "org/gnome/system/location".enabled = true;
    "org/gtk/settings/file-chooser".clock-format = "24h";


    # shortcuts
    "org/gnome/shell/keybindings".toggle-message-tray = ["<Super>b"];
    "org/gnome/settings-daemon/plugins/media-keys".control-center = ["<Super>F12"];
    "org/gnome/settings-daemon/plugins/media-keys".home = ["<Super>f"];
    "org/gnome/settings-daemon/plugins/media-keys".reboot = ["<Shift><Control>Escape"];
    "org/gnome/settings-daemon/plugins/media-keys".search = ["<Super>F3"];
    "org/gnome/settings-daemon/plugins/media-keys".shutdown = ["<Control>Escape"];

    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0".binding = "<Super>t";
    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0".command = "kgx";
    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0".name = "Terminal";
    "org/gnome/settings-daemon/plugins/media-keys".custom-keybindings = ["/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/"];
    
    # Enable installed extensions
    "org/gnome/shell" = {
      disable-user-extensions = false;
      enabled-extensions = map (extension: extension.extensionUuid) [
        pkgs.gnomeExtensions.arcmenu
        pkgs.gnomeExtensions.blur-my-shell
        pkgs.gnomeExtensions.caffeine
        pkgs.gnomeExtensions.daily-bing-wallpaper
        pkgs.gnomeExtensions.dash-to-panel
        pkgs.gnomeExtensions.gsconnect
        pkgs.gnomeExtensions.gtk4-desktop-icons-ng-ding
        pkgs.gnomeExtensions.night-theme-switcher
        pkgs.gnomeExtensions.removable-drive-menu
        pkgs.gnomeExtensions.remove-world-clocks
      ];
     
      #disabled-extensions = [ 
      #  pkgs.gnomeExtensions.dash-to-panel.extensionUuid 
      #];
      
      favorite-apps = [
        "org.gnome.Nautilus.desktop",
        "firefox.desktop"
        "org.gnome.Music.desktop"
      ];
    };
    
    "org/gnome/shell/extensions/nightthemeswitcher/time" = {
      fullscreen-transition = true;
      manual-schedule = false;
    };

    "org/gnome/shell/extensions/arcmenu" = {
      apps-show-extra-details = false;
      arc-menu-icon = 33;
      button-item-icon-size = 'Small';
      button-padding = 3;
      context-menu-items = [
        {"id": "gnome-about-panel.desktop"}
        {"id": "io.missioncenter.MissionCenter.desktop", "name": "Gestionnaire des tâches"}
        {"id": "ArcMenu_Separator", "name": "Séparateur", "icon": "list-remove-symbolic"}
        {"id": "ArcMenu_PowerOptions", "name": "Power Options", "icon": "system-shutdown-symbolic"}
        {"id": "org.gnome.Settings.desktop"}
        {"id": "ArcMenu_PanelExtensionSettings", "name": "Paramètres des extensions du panneau", "icon": "application-x-addon-symbolic" }
        {"id": "ArcMenu_Separator", "name": "Separator", "icon": "list-remove-symbolic"}
        {"id": "ArcMenu_ShowDesktop", "name": "Show Desktop", "icon": "computer-symbolic"}
      ];
      custom-menu-button-icon-size = 40;
      dash-to-panel-standalone = true;
      distro-icon = 22;
      force-menu-location = "BottomCentered";
      hide-overview-on-startup = true;
      left-panel-width = 290;
      #menu-button-active-bg-color = (true, "rgba(242,242,242,0.2)");
      #menu-button-active-fg-color = (false, "rgb(242,242,242)");
      menu-button-appearance = "Icon";
      #menu-button-bg-color = (false, "rgba(242,242,242,0.2)");
      menu-button-border-radius = (true, 8);
      menu-button-border-width = (true, 0);
      #menu-button-fg-color = (false, "rgb(242,242,242)");
      menu-button-hover-bg-color = (true, "rgba(242,242,242,0.15)");
      #menu-button-hover-fg-color = (false, "rgb(242,242,242)");
      menu-button-icon = "Distro_Icon";
      menu-button-position-offset = 0;
      menu-height = 700;
      menu-item-grid-icon-size = "Large";
      menu-layout = "Eleven";
      menu-width-adjustment = 125;
      misc-item-icon-size = "Default";
      multi-monitor = true;
      override-menu-theme = false;
      pinned-apps = [
        {"id": "org.gnome.Contacts.desktop"}
        {"id": "org.gnome.Nautilus.desktop"}
        {"id": "firefox.desktop"}
        {"id": "thunderbird.desktop"}
        {"id": "onlyoffice-desktopeditors.desktop"}
        {"id": "signal.desktop"}
        {"id": "org.gnome.Software.desktop"}
        {"id": "org.gnome.Photos.desktop"}
        {"id": "org.gnome.Music.desktop"}
        {"id": "code.desktop"}
        {"id": "io.missioncenter.MissionCenter.desktop"}
      ];
      position-in-panel = "Left";
      power-display-style = "Default";
      power-options = [(0, true) (1, true)  (2, true)  (3, true)  (4, false)  (5, true) (6, true) (7, true)];
      prefs-visible-page = 0;
      quicklinks-item-icon-size = "Default";
      right-panel-width = 205;
      show-activities-button = true;
    };

    "org/gnome/shell/extensions/dailybingwallpaper" = {
      region = "fr-FR";
    };

    "org/gnome/shell/extensions/dash-to-panel" = {

    };

    "org/gnome/shell/extensions/gsconnect".show-indicators = true;

    "/org/gnome/nautilus/preferences" = {
      show-create-link = true;
      show-delete-permanently = false; # users can misclicked and i don't want to have complains about it.
      date-time-format = "detailed";
    };

    "/org/gnome/nautilus/icon-view" = {
      captions = ["size" "none" "none"];
    };


  	# "org/gnome/Weather" = { "locations" = "[<(uint32 2, <('Gdańsk', 'EPGD', true, [(0.94916821905848536, 0.32230414101938371)], [(0.94858644845891815, 0.32579479952337237)])>)>, <(uint32 2, <('Gdynia, Działdowo County, Warmian-Masurian Voivodeship', '', false, [(0.93027949445787339, 0.34699627038777753)], [(0.93861053042695397, 0.35744550775024858)])>)>, <(uint32 2, <('Gdynia, Pomeranian Voivodeship', '', false, [(0.95149239024756216, 0.32358882203124067)], [(0.94858644845891815, 0.32579479952337237)])>)>]"; };
  };

  gtk = {
    enable = true;
    
    theme = {
      name = "adw-gtk3";
      #package = pkgs.adw-gtk3;
    };
    
    cursorTheme = {
      name = "macOS";
      package = pkgs.apple-cursor;
    };
  };

  programs = {
	bash.enable = true;
  
    # dev stuff :)
    git = {
      enable = true;
      userEmail = "dorian.leveque@proton.me";
      userName = "dorian.leveque";
      ignores = [ "node_modules" "build" "dist" ];	
    };

    #gnome-shell = {
    #  enable = true;
    #  theme = {
    #    name = "adwaita";
    #    package = pkgs.libadwaita;
    #  };
    #};*/

    # Let Home Manager install and manage itself.
    home-manager.enable = true;
  };
}
