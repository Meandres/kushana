{ system, pkgs, home-manager, lib, user, ... }:
with builtins;
{
  mkHost = { name, NICs, initrMods, kernelMods, kernelParams, kernelPackage, gpuTempSensor ? null, cpuTempSensor ? null
  } :
  let networkCfg = listToAttrs (map (n: {
    name = "${n}"; value = { useDHCP = true;};
  }) NICs );

  userCfg = {
    inherit name NICs systemConfig cpuCores gpuTempSensor cpuTempSensor;
  };

  sys_users = (map (u: user.mkSystemUser u) users);
  in lib.nixosSystem {
    inherit system;
  
    modules = [
      {
        imports = [ ../modules/system ] ++ sys_users;
        
        jd = systemConfig;

        environment.etc = {
          "hmsystemdata.json".text = toJSON userCfg;
        };
  }

https://jdisaacs.com/blog/nixos-config/
}
