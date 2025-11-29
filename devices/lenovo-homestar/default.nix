{ config, lib, pkgs, ... }:

{
  imports = [
    ../families/mainline-chromeos-sc7180
  ];

  mobile.device.name = "lenovo-homestar";
  mobile.device.identity = {
    name = "Chromebook Duet 5 (13”)";
    manufacturer = "Lenovo";
  };
  mobile.device.supportLevel = "supported";

  mobile.hardware = {
    screen = {
      # Panel is portrait CW compared to keyboard attachment.
      width = 1080; height = 1920;
    };
  };

  environment.systemPackages = with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    git
    wget
  ];
  networking.networkmanager.enable = false;
  networking.wireless.enable = true; # to use wpa_supplicant

  # # sc7180
  # nixpkgs.config.allowUnfree = true;
  # hardware.firmware = [ 
  #   pkgs.chromeos-sc7180-unredistributable-firmware
  # ];


  # Ensure orientation match with keyboard.
  services.udev.extraHwdb = lib.mkBefore ''
    sensor:accel-display:modalias:platform:cros-ec-accel:*
      ACCEL_MOUNT_MATRIX=0, 1, 0; -1, 0, 0; 0, 0, -1
  '';
}
