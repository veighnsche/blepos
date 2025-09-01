{ pkgs, ... }:
{
  users.users.vince = {
    isNormalUser = true;
    description = "vince";
    extraGroups = [ "wheel" "networkmanager" "video" "audio" "seat" ];
    shell = pkgs.bashInteractive;
  };
}
