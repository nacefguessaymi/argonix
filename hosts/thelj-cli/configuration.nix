{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:
let
  gogh = import ../../lib/gogh.nix { inherit lib; };
in
{
  imports = [
    ./hardware-configuration.nix
    ./filesystems.nix
  ];

  home-manager.users.nacef = {
    theme = gogh "${inputs.gogh}/data/json/nord.json" // {
      helix = "nord";
    };
    wayland.windowManager.mango.extraConfig = "monitor_rule=make:ASUSTek COMPUTER INC,model:PA32QCV,serial:T7LMSV009006,x:0,y:0,scale:2";
  };
  boot.loader.systemd-boot.enable = true;
  boot.loader.systemd-boot.configurationLimit = 10;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.kernelPackages = pkgs.linuxPackages_latest;

  networking.hostName = "thelj-cli"; # Define your hostname.

  networking.networkmanager.enable = true;

  time.timeZone = "America/New_York";

  # Enable the X11 windowing system.
  # services.xserver.enable = true;

  # Configure keymap in X11
  # services.xserver.xkb.layout = "us";
  # services.xserver.xkb.options = "eurosign:e,caps:escape";

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  # services.pulseaudio.enable = true;
  # OR
  # services.pipewire = {
  #   enable = true;
  #   pulse.enable = true;
  # };

  users.users.nacef = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "networkmanager"
    ]; # Enable ‘sudo’ for the user.
    packages = with pkgs; [
      tree
    ];
  };

  environment.systemPackages = with pkgs; [
    git
  ];

  programs.mango.enable = true;

  # services.openssh.enable = true;
  services.greetd = {
    enable = true;
    settings.default_session = {
      command = "${pkgs.tuigreet}/bin/tuigreet --time --remember --cmd mango";
      user = "greeter";
    };
  };

  system.stateVersion = "26.05"; # Did you read the comment?
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

}
