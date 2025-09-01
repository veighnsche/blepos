{ ... }:
{
  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ 22 3535 8188 ];
    allowedUDPPortRanges = [ { from = 27031; to = 27036; } ];
    allowedTCPPortRanges = [ { from = 27036; to = 27037; } ];
  };
}
