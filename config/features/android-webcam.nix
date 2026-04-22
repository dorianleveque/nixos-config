# Enable android webcam
{ config, lib, pkgs, ... }:

{
  options.features.virtualAndroidWebcam.enable = lib.mkEnableOption "Android webcam with debug mode";

  config = lib.mkIf config.features.virtualAndroidWebcam.enable {
    
    # Install required packages
    environment.systemPackages = with pkgs; [
      scrcpy
      ffmpeg
    ];
    
    boot = {
      extraModulePackages = with config.boot.kernelPackages; [
        v4l2loopback # Virtual cam
      ];
      
      # Create the virtual cam
      extraModprobeConfig = '' 
        options v4l2loopback \
          video_nr=0 \
          card_label="Android Webcam (mode développeur)" \
          exclusive_caps=1 \
          devices=1
      '';
      
      kernelModules = [ "v4l2loopback" ];
    };
    
    # Create the virtual camera
    services.pipewire = {
      enable = true;     
      extraConfig.pipewire = {
        "v4l2loopback" = {
          context.properties = {
            "default.clock.rate" = 48000;
            "log.level" = 3;
          };
          context.modules = [
            {
              name = "libcamera";
              args = {
                "camera.name" = "v4l2loopback-camera";
                "device.name" = "/dev/video0";
              };
            }
          ];
        };
      };
    };
    
    # Add an action that launch the our service if a USB is pluged in.
    services.udev.extraRules = ''
      ACTION=="add", SUBSYSTEM=="usb", TAG+="systemd", ENV{SYSTEMD_USER_WANTS}="scrcpy-webcam"
    '';
    
    # Deploy a service to launch the debug with Android adb via scrcpy
    systemd.user.services.scrcpy-webcam = {
      description = "Android webcam (developer mode)";

      serviceConfig = {
        ExecStart = ''
          ${pkgs.scrcpy}/bin/scrcpy \
            --v4l2-sink=/dev/video0 \
            --video-source=camera \
            --camera-facing="front" \
            --video-bit-rate=400k \
            --max-size=1024 \
            --crop=720:480:60:200 \
            --no-audio \
            --no-window
        '';
        Restart = "on-failure";
        RestartMode = "direct";
        RestartForceExitStatus = 2;
        RestartPreventExitStatus = 1;
        RestartSec = 5;
        
        # Max 3 tentatives (échecs + crashs)
        StartLimitIntervalSec = 60;
        StartLimitBurst = 3;
      };
    };
  };
}
