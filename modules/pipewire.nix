{ ... }:

{
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    
    alsa = {
      enable = true;
      support32Bit = true;
    };
        
    extraConfig.pipewire."92-low-latency" = {
      "context.properties" = {
        "default.clock.rate" = 48000;
        "default.clock.quantum" = 256;
        "default.clock.min-quantum" = 256;
        "default.clock.max-quantum" = 256;
      };
    };
    
    jack.enable = true;
    pulse.enable = true;
  };
}
