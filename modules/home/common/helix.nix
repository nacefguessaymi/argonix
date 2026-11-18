{ config, pkgs, ... }: {
  programs.helix = {
    enable = true;
    defaultEditor = true;

    extraPackages = with pkgs; [
      nil
      nixfmt
      basedpyright
      ruff
      lua-language-server
    ];

    settings = {
      theme = config.theme.helix;

      editor = {
        line-number = "absolute";
        color-modes = true;
        cursorline = true;
        bufferline = "multiple";
        true-color = true;
        mouse = true;
        gutters = [
          "diagnostics"
          "spacer"
          "line-numbers"
          "spacer"
          "diff"
        ];
        auto-completion = true;
        path-completion = true;
        auto-format = true;
        completion-timeout = 1000;
        preview-completion-insert = true;
        completion-trigger-len = 4;
        end-of-line-diagnostics = "hint";
        inline-diagnostics.cursor-line = "warning";

        indent-guides = {
          render = true;
          character = "▏";
        };

        cursor-shape = {
          normal = "block";
          insert = "bar";
          select = "underline";
        };

        statusline = {
          left = [
            "mode"
            "spinner"
            "version-control"
            "file-name"
            "file-modification-indicator"
          ];
          right = [
            "diagnostics"
            "file-encoding"
            "file-line-ending"
            "file-type"
            "position-percentage"
            "position"
          ];
          separator = "|";
        };

        lsp = {
          display-inlay-hints = true;
          display-color-swatches = true;
        };
      };
    };

    languages = {
      language-server = {
        basedpyright = {
          command = "basedpyright-langserver";
          args = [ "--stdio" ];
        };
        ruff = {
          command = "ruff";
          args = [ "server" ];
        };
      };

      language = [
        {
          name = "nix";
          auto-format = true;
          formatter.command = "nixfmt";
        }
        {
          name = "python";
          auto-format = true;
          language-servers = [
            "basedpyright"
            "ruff"
          ];
          code-actions-on-save = [
            {
              code-action = "source.organizeImports";
              enabled = true;
            }
          ];
        }
      ];
    };

    themes = {
      transparent = {
        inherits = config.theme.helix;
        "ui.background" = { };
      };
    };
  };
}
