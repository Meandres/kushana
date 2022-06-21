{
    description = "KushanaOS flake";

    inputs = {
        nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
        nur.url = "github:nix-community/NUR";
    };

    outputs = inputs@{ self, nixpkgs, nur, ...} : {
        packages.x86_64-linux = let
            pkgs = import nixpkgs { 
                system = "x86_64-linux";
                config.allowUnfree = true;
            };
            in {
                nix = nixpkgs.nix;
            };

            nixosConfigurations = {
                teto = nixpkgs.lib.nixosSystem {
                    system = "x86_64-linux";
                    extraArgs = { inherit nur; };
                    modules = [
                        self.nixosModules.overlay
                        ./configs/configuration-teto.nix
                    ];
                };
            };
    };
}
