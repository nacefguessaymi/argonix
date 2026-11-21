{
  config,
  lib,
  pkgs,
  ...
}:
let
  t = config.theme;
  p = i: builtins.elemAt t.palette i;
  c = alpha: hex: "0x${lib.removePrefix "#" hex}${alpha}";

  mod = "SUPER";
  terminal = "ghostty";
  fileManager = "ghostty -e yazi";

  tagBinds = builtins.concatLists (
    builtins.genList (
      i:
      let
        n = toString (i + 1);
      in
      [
        "${mod},${n},view,${n},0"
        "${mod}+SHIFT,${n},tag,${n},0"
      ]
    ) 9
  );
in
{
  home.packages = with pkgs; [
    grim
    slurp
    wl-clipboard
    wlr-randr
  ];

  wayland.windowManager.mango = {
    enable = true;
    systemd.enable = true;

    settings = {
      root_color = c "ff" t.background;
      focus_color = c "ff" (p 4);
      border_color = c "aa" (p 8);
      urgent_color = c "ff" (p 1);
      scratchpad_color = c "ff" (p 6);
      shadows_color = c "ee" t.background;
      cursor_size = 12;

      border_px = 1;
      gap_inner_horizontal = 5;
      gap_inner_vertical = 5;
      gap_outer_horizontal = 5;
      gap_outer_vertical = 5;
      border_radius = 10;
      focused_opacity = 1.0;
      unfocused_opacity = 0.75;

      blur = 1;
      blur_optimized = 1;
      blur_params = {
        radius = 3;
        num_passes = 1;
      };

      shadows = 1;
      layer_shadows = 0;
      shadow_only_floating = 0;
      shadows_size = 4;

      animations = 1;
      animation_type_open = "zoom";
      animation_type_close = "zoom";
      animation_curve = {
        open = "0.23,1.0,0.32,1";
        close = "0,0,1,1";
      };

      tag_rule = [ "id:*,layout_name:dwindle" ];

      bind = [
        "${mod},Q,spawn,${terminal}"
        "${mod},C,killclient"
        "${mod},M,quit"
        "${mod},E,spawn,${fileManager}"
        "${mod},B,spawn,${"zen-beta"}"
        "${mod},V,togglefloating"
        "${mod},F,togglefullscreen"
        "${mod}+SHIFT,R,reload_config"

        "${mod},Left,focusdir,left"
        "${mod},Right,focusdir,right"
        "${mod},Up,focusdir,up"
        "${mod},Down,focusdir,down"

        "${mod}+SHIFT,Left,move_client,left"
        "${mod}+SHIFT,Right,move_client,right"
        "${mod}+SHIFT,Up,move_client,up"
        "${mod}+SHIFT,Down,move_client,down"

        "${mod},S,toggle_special_tag"
        "${mod}+SHIFT,S,tag_special_tag"

        "NONE,Print,spawn_shell,grim -g \"$(slurp)\" - | wl-copy"
        "SHIFT,Print,spawn_shell,grim - | wl-copy"
      ]
      ++ tagBinds;

      mousebind = [
        "${mod},btn_left,moveresize,curmove"
        "${mod},btn_right,moveresize,curresize"
      ];

      axisbind = [
        "${mod},DOWN,viewtoright_have_client"
        "${mod},UP,viewtoleft_have_client"
      ];

      window_rule = [
        "ignore_maximize:1,app_id:.*"
        "is_floating:1,is_global:1,is_overlay:1,no_border:1,app_id:^zoom$,title:^as_toolbar$"
      ];
    };
  };
}
