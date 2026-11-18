{
  inputs = {
    nixpkgs.url = "github:NixOs/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    gogh = {
      url = "github:Gogh-Co/Gogh";
      flake = false;
    };
  };

  outputs =
    { nixpkgs, home-manager, ... }@inputs:
    {
      nixosConfigurations.thelj-cli = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = [
          ./hosts/thelj-cli/configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.extraSpecialArgs = { inherit inputs; };
            home-manager.users.nacef = import ./home/nacef.nix;
          }
        ];
      };
    };
}
