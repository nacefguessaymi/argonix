{ config, pkgs, ... }:
let
  t = config.theme;
  p = i: builtins.elemAt t.palette i;

  bg = t.background;
  fg = t.foreground;
  surface = p 0;
  overlay = p 8;
  muted = p 7;
  red = p 9;
  green = p 10;
  accent = p 11;
  blue = p 12;
  magenta = p 13;
in
{
  programs.zathura.enable = true;

  programs.yazi = {
    enable = true;
    enableBashIntegration = true;

    settings = {
      opener.pdf = [
        {
          run = ''zathura "$@"'';
          desc = "Open with zathura";
          orphan = true;
        }
      ];
      open.prepend_rules = [
        {
          mime = "application/pdf";
          use = "pdf";
        }
      ];
    };
    theme = {
      mgr = {
        cwd.fg = blue;
        find_keyword = {
          fg = green;
          italic = true;
        };
        find_position = {
          fg = accent;
          bg = "reset";
          italic = true;
        };
        marker_selected = {
          fg = green;
          bg = green;
        };
        marker_copied = {
          fg = green;
          bg = green;
        };
        marker_cut = {
          fg = red;
          bg = red;
        };
        border_symbol = "|";
        border_style.fg = overlay;
      };

      indicator = {
        current = {
          fg = bg;
          bg = blue;
        };
        preview.underline = true;
      };

      tabs = {
        active = {
          fg = bg;
          bg = overlay;
        };
        inactive = {
          fg = muted;
          bg = surface;
        };
      };

      mode = {
        normal_main = {
          fg = bg;
          bg = muted;
          bold = true;
        };
        normal_alt = {
          fg = bg;
          bg = muted;
          bold = true;
        };
        select_main = {
          fg = bg;
          bg = green;
          bold = true;
        };
        select_alt = {
          fg = bg;
          bg = green;
          bold = true;
        };
        unset_main = {
          fg = bg;
          bg = magenta;
          bold = true;
        };
        unset_alt = {
          fg = bg;
          bg = magenta;
          bold = true;
        };
      };

      status = {
        sep_left = {
          open = "";
          close = "";
        };
        sep_right = {
          open = "";
          close = "";
        };
        progress_label = {
          fg = fg;
          bold = true;
        };
        progress_normal = {
          fg = overlay;
          bg = surface;
        };
        progress_error = {
          fg = red;
          bg = surface;
        };
        perm_type.fg = overlay;
        perm_read.fg = green;
        perm_write.fg = red;
        perm_exec.fg = green;
        perm_sep.fg = overlay;
      };

      input = {
        border.fg = overlay;
        selected.reversed = true;
      };

      select = {
        border.fg = overlay;
        active.fg = accent;
      };

      tasks = {
        border.fg = overlay;
        hovered.underline = true;
      };

      which = {
        mask.bg = surface;
        cand.fg = blue;
        rest.fg = overlay;
        desc.fg = accent;
        separator = "    ";
        separator_style.fg = overlay;
      };

      help = {
        on.fg = accent;
        run.fg = blue;
        desc.fg = overlay;
        hovered = {
          bg = overlay;
          bold = true;
        };
        footer = {
          fg = surface;
          bg = muted;
        };
      };

      filetype.rules = [
        {
          mime = "image/*";
          fg = blue;
        }
        {
          mime = "{audio,video}/*";
          fg = green;
        }
        {
          mime = "application/{zip,gzip,x-tar,x-bzip,x-bzip2,x-7z-compressed,x-rar}";
          fg = accent;
        }
        {
          url = "*/";
          fg = blue;
        }
        {
          url = "*";
          fg = muted;
        }
      ];
    };
  };
}
