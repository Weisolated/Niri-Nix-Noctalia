{ config, pkgs, inputs, ... }:

{
  environment.systemPackages = with pkgs; [
    xwayland-satellite
    ghostty
    mangohud
    protonup-ng
    wine
    winetricks
    vulkan-loader
    mesa
    libva
    mpv
    ffmpeg
    tela-circle-icon-theme
    appimage-run
    unrar # Tool For Handling .rar Files
    unzip # Tool For Handling .zip Files
    btop-cuda
    fuzzel
    cava
    lxqt.lxqt-policykit
    libappimage
    nvtopPackages.full 
    wineWow64Packages.waylandFull
    xeyes
    git
    # Python + GTK Layer Shell
    (python3.withPackages (ps: with ps; [
      pygobject3
      pillow
    ]))
    gtk3
    gtk-layer-shell
  gobject-introspection
    nemo
darkly
vicinae
];

 qt.platformTheme = "qt6ct";
 programs.localsend.openFirewall = true;
 programs.localsend.enable = true;
 programs.steam.enable = true;
 programs.steam.gamescopeSession.enable = true;
 programs.gamemode.enable = true;
 programs.niri.enable = true;

}
