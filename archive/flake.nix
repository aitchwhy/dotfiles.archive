{
  description = "aitchwhyz's flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-24.05-darwin";
    # Pin darwin to a particular release
    nix-darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # Also pin home-manager to same version so that it would not issue the mismatch error
    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # Nix-tree (debug tree view for Nix derivations)
    # nix-tree = {
    #   url = "github:utdemir/nix-tree/rele" "github:nix-community/home-manager/release-24.05";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs, home-manager, ... }: {
    darwinConfigurations = {
      "aitch-mbp-patter" = nix-darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        modules = [
          ./darwin/darwin.nix
          home-manager.darwinModules.home-manager
          {
            _module.args = { inherit inputs; };
            home-manager = {
              users.hank = import ./home/home.nix;
            };
            users.users.hank.home = "/Users/hank";
          }
        ];
      };
    };
  };
}
