{ nixpkgs, options, modulesPath, lib, config, pkgs, ... } : 
{
    imports = [
        ./base.nix
    ];

    config = {
        nixpkgs.config.allowUnfree = true;
        
        program.browserpass = {
            enable = true;
            browsers = [ "firefox" ];
        };
        
        environment .systemPackages = with pkgs; [
        vim
        git
        firefox
        evince
        gcc
        wget
        gtk4
        gtk3
        gtk2
        xfce.exo
        xfce.libxfce4ui
        xfce.xfce4-icon-theme
        xfce.xfce4-settings
        xfce.xfce4--whiskermenu-plugin
        xfce.xfconf
        tdesktop
        ];
    };
}
