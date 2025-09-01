{ pkgs, ... }:
{
  services.greetd = {
    enable = true;
    settings.initial_session = {
      command = "sway";
      user = "vince";
    };
  };
  services.xserver.enable = false;
  programs.sway.enable = true;
  services.seatd.enable = true;

  xdg.portal = {
    enable = true;
    wlr.enable = true;
    extraPortals = with pkgs; [ xdg-desktop-portal-gtk ];
  };
}
