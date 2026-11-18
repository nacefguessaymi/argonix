{ lib }:
file:
let
  t = builtins.fromJSON (builtins.readFile file);
in
{
  name = t.name;
  background = t.background;
  foreground = t.foreground;
  cursor = t.cursor;
  palette = map (i: t."color_${lib.fixedWidthNumber 2 i}") (lib.range 1 16);
}
