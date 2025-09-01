{ lib, ... }:
{
  # Bootloader: systemd-boot (EFI), Intel microcode, firmware
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  hardware.cpu.intel.updateMicrocode = lib.mkDefault true;
  hardware.enableRedistributableFirmware = true;
}
