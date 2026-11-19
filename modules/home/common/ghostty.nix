{ config, lib, ... }:
let
  t = config.theme;
in
{
  programs.ghostty = {
    enable = true;

    themes.gogh = {
      background = t.background;
      foreground = t.foreground;
      cursor-color = t.cursor;
      palette = lib.imap0 (i: c: "${toString i}=${c}") t.palette;
    };
    settings = {
      theme = "gogh";
      font-family = builtins.head config.fonts.fontconfig.defaultFonts.monospace;
      gtk-single-instance = true;
    };
  };
}
