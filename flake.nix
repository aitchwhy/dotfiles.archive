{
  description = "Hank's Nix flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = {
    darwin,
    home-manager,
    ...
  } @ inputs: {
    darwinConfigurations = {
     hostname = darwin.lib.darwinSystem {
        # system = "x86_64-darwin";
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
