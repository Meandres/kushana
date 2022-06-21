{
  description = "KushanaOS config";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
  
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs: 
  
  let 
    inherit (nixpkgs) lib;
    
    util = import ./lib {
      inherit system pkgs home-manager lib; overlays = (pkgs.overlays);
    };

    inherit (util) user;
    inherit (util) host;

    pkgs = import nixpkgs {
      inherit system;
      config.allowUnfree = true;
    };
    
    system = "x86_64-linux";
    in {
      homeManagerConfigurations = {
        jd = user.mkHMUser {
          #
        };
      };

      nixosConfigurations = {
        laptop = host.mkHost {
          #
        };
      };
  };

}
