{ ... }:
{
  xdg.configFile."foot/foot.ini".text = ''
# -*- conf -*-

[main]
font=IBM Plex Mono:size=12
initial-window-size-chars=120x32
pad=8x8 center-when-maximized-and-fullscreen
resize-keep-grid=yes

[environment]

[security]

[bell]

[desktop-notifications]

[scrollback]
lines=5000
multiplier=3.0

[url]
launch=xdg-open ${url}
osc8-underline=url-mode

[cursor]
style=beam
blink=yes

[mouse]
hide-when-typing=yes

[touch]

[colors]
alpha=0.9
'';
}
