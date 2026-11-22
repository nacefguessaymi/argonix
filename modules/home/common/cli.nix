{ pkgs, ... }:
{
  programs = {
    btop.enable = true;
    fzf.enable = true;
    fastfetch.enable = true;
    jq.enable = true;
    htop.enable = true;
    starship.enable = true;
    tmux.enable = true;
  };

  home.packages =
    with pkgs;
    [
      _7zz
      curl
      fastfetch
      glow
      imagemagick
      nmap
      peaclock
      rsync
      tree
      typst

    ]
    ++ lib.utils.optionals stdenv.isLinux [
      pciutils
      usbutils
      strace
    ];
}
