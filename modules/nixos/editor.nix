{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    helix
    nil
    nixfmt
  ]
}
