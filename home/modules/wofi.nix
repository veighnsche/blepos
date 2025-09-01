{ ... }:
{
  xdg.configFile."wofi/style.css".text = ''
window {
    border-radius: 6px;
    border: none;
    background-color: #323232;
    color: #ffffff;
    box-shadow: none;
  }
  #entry:selected {
    background-color: #5c5c5c;
    color: #ffffff;
  }
  
* {
  font-family: "JetBrains Mono", monospace;
  font-size: 14px;
  box-shadow: none;
}

#outer-box { padding: 6px; }
#inner-box { padding: 6px; border: none; border-radius: 6px; background: transparent; }

#input {
  padding: 8px 10px;
  margin-bottom: 6px;
  border: none;
  border-radius: 4px;
  background: #323232;
  color: #ffffff;
  caret-color: #ffffff;
  outline: none;
  box-shadow: none;
}

#prompt { color: #ffffff; margin-right: 8px; }

#listview { padding: 4px 0; }
#scroll { border: none; }

#entry { padding: 8px 10px; border-radius: 4px; background: transparent; }
#entry #img { margin-right: 8px; }
#entry #text { color: #ffffff; }
#entry:selected #text { color: #ffffff; }

#listview > *:not(:first-child) { border-top: none; }

tooltip { background: #323232; color: #ffffff; border: none; }
'';
}
