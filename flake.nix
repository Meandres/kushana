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
        Meandres = user.mkHMUser {
          #
        };
      };

      nixosConfigurations = {
        work_laptop = host.mkHost {
          name = "yupa";
          NICs = [ "enp0s31f6" "wlp1s0"];
          kernelPackages = pkgs.linuxPackages;
          initrdMods = [ "xhci_pci" "ahci" "usb_storage" "sd_mod" "rtsx_pci_sdmmc" ];
          kernelMods = [ "kvm-intel" ];
          kernelParams = [];
          systemConfig = {
            # To fill
          };
          users = [{
            name = "Meandres";
            groups = [ "wheel" "networkmanager" "docker" ];
            uid = 1000;
            shell = pkgs.bash;
          }];
         cpuCores = 4;
        };
      };
  };

}
