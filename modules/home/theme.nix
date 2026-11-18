{ lib, ... }:
let
  inherit (lib) mkOption types;
in
{
  options.theme = {
    name = mkOption { type = types.str; };
    helix = mkOption { type = types.str; };
    background = mkOption { type = types.str; };
    foreground = mkOption { type = types.str; };
    cursor = mkOption { type = types.str; };
    palette = mkOption {
      type = types.listOf types.str;
      description = "ANSI colors 0-15";
    };
  };
}
