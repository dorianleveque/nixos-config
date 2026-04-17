{ config, lib, pkgs, ... }:

{
  programs = {
    
    # Config the default gnome settings on the system
    dconf.profiles.user.databases = [
      {
        lockAll = true; # prevents overriding by users
        settings = {
          # Force the legacy gtk theme to match the Adwaita theme.
          "org/gnome/desktop/interface".gtk-theme = "adw-gtk3";
          
          # Force the locate pointer animation when user press Ctrl key.
          "org/gnome/desktop/interface".locate-pointer = true;
          
          # Force the middle click paste
          "org/gnome/desktop/interface".gtk-enable-primary-paste = true;
          
          "org/gnome/mutter".attach-modal-dialogs = true;
          "org/gnome/mutter".center-new-windows = true;
          
          "org/gnome/shell/extensions/gsconnect".show-indicators = true;
          "org/gnome/shell/extensions/nightthemeswitcher/time" = {
            fullscreen-transition = true;
            manual-schedule = false;
          };
          
          # In picture extension
          "org/gnome/shell/extensions/in-picture".diagonal-relative = lib.gvariant.mkInt32 20;
          "org/gnome/shell/extensions/in-picture".hide = true;
          "org/gnome/shell/extensions/in-picture".identifiers = [
            ["Picture-in-Picture" ""]
            ["Picture in picture" ""]
            ["Picture-in-picture" ""]
            ["TelegramDesktop" ""]
            ["Incrustation" ""]
            ["PIP" ""]
          ];
          "org/gnome/shell/extensions/in-picture".margin-x = lib.gvariant.mkInt32 60;
          "org/gnome/shell/extensions/in-picture".margin-y = lib.gvariant.mkInt32 60;
          "org/gnome/shell/extensions/in-picture".stick = true;
          "org/gnome/shell/extensions/in-picture".top = true;
          
          # shortcuts
          "org/gnome/mutter".overlay-key = "Super";
          "org/gnome/settings-daemon/plugins/media-keys".logout = ["<Control><Alt>Delete"];
          "org/gnome/settings-daemon/plugins/media-keys".reboot = ["<Shift><Control>Escape"];
          "org/gnome/settings-daemon/plugins/media-keys".screensaver = ["<Super>l"];
          "org/gnome/settings-daemon/plugins/media-keys".shutdown = ["<Control>Escape"];
          "org/gnome/shell/keybindings".toggle-message-tray = ["<Super>b"];
          
          "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0".binding = "<Super>t";
          "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0".command = "kgx";
          "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0".name = "Terminal";
          "org/gnome/settings-daemon/plugins/media-keys".custom-keybindings = ["/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/"];
        };
      }
      {
        lockAll = false; # user can change the following settings
        settings = {
          # default gnome settings
          "org/gnome/desktop/calendar".show-weekdate = true;
          "org/gnome/desktop/interface".clock-show-weekday = true;
          "org/gnome/desktop/input-sources".xkb-options = ["terminate:ctrl_alt_bksp" "compose:rctrl"];
          "org/gnome/desktop/peripherals/mouse".natural-scroll = false;
          "org/gnome/desktop/wm/preferences".action-double-click-titlebar = "toggle-maximize";
          "org/gnome/desktop/wm/preferences".action-middle-click-titlebar = "none";
          "org/gnome/desktop/wm/preferences".action-right-click-titlebar = "menu";
          "org/gnome/desktop/wm/preferences".button-layout = "appmenu:minimize,maximize,close"; 
          "org/gnome/desktop/wm/preferences".focus-mode = "sloppy";
          "org/gnome/desktop/wm/preferences".mouse-button-modifier = "<Super>";

          "org/gnome/system/location".enabled = true;
          "org/gtk/settings/file-chooser".clock-format = "24h";
          
          # shortcuts
          "org/gnome/settings-daemon/plugins/media-keys".control-center = ["<Super>F12"];
          "org/gnome/settings-daemon/plugins/media-keys".home = ["<Super>f"];
          "org/gnome/settings-daemon/plugins/media-keys".search = ["<Super>F3"];
          "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0".binding = "<Super>t";
          "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0".command = "kgx";
          "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0".name = "Terminal";
          "org/gnome/settings-daemon/plugins/media-keys".custom-keybindings = ["/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/"];
          
          # Enable installed extensions
          "org/gnome/shell" = {
            disable-user-extensions = false;
            enabled-extensions = map (extension: extension.extensionUuid) [
              pkgs.gnomeExtensions.arcmenu
              pkgs.gnomeExtensions.caffeine
              pkgs.gnomeExtensions.dash-to-panel
              pkgs.gnomeExtensions.desktop-icons-ng-ding
              pkgs.gnomeExtensions.gsconnect
              pkgs.gnomeExtensions.in-picture
              pkgs.gnomeExtensions.night-theme-switcher
              pkgs.gnomeExtensions.removable-drive-menu
            ];
            
            favorite-apps = [
              "firefox.desktop"
              "org.gnome.Nautilus.desktop"
              "signal.desktop"
              "code.desktop"
              "io.missioncenter.MissionCenter.desktop"
              "org.gnome.Music.desktop"
            ];
          };
          
          # default nautilus settings
          "org/gnome/nautilus/preferences" = {
            show-create-link = true;
            # users can misclicked and i don't want to have complains about it.
            show-delete-permanently = false;
            date-time-format = "detailed";
          };

          "org/gnome/nautilus/icon-view" = {
            captions = ["size" "none" "none"];
            default-zoom-level = "small-plus";
          };
        };
      }
    ];
    
    # Config GSConnect
    kdeconnect = {
      enable = true;
      package = pkgs.gnomeExtensions.gsconnect;
    };
    
  };
  
  environment = {
    
    # Change the default gtk-3.0 theme to adw-gtk3 theme 
    # to better match the Adwaita theme described in gtk-4.0.
    etc."gtk-3.0/settings.ini".text = ''
      [Settings]
      gtk-theme-name=adw-gtk3
    '';
    
    gnome.excludePackages = with pkgs; [
      gnome-tour
      gnome-system-monitor
    ];
    
    systemPackages = with pkgs; [
      adw-gtk3
      gnome-photos
      gnome-tweaks
      gnomeExtensions.arcmenu
      gnomeExtensions.bluetooth-battery-meter
      gnomeExtensions.caffeine
      gnomeExtensions.dash-to-panel
      gnomeExtensions.desktop-icons-ng-ding
      gnomeExtensions.gsconnect
      gnomeExtensions.night-theme-switcher
      gnomeExtensions.in-picture
      gnomeExtensions.mpris-label
      gnomeExtensions.removable-drive-menu
      mission-center # replace gnome-system-monitor
    ];
  };
  
  services = {
  
    # Enable the GNOME Desktop Environment.
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
    
  };
}
