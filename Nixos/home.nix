{ inputs, pkgs, ... }:


#let
 # spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.system};
#in

{
  home.username = "xxxxx";
  home.homeDirectory = "/home/xxxxx";
  home.stateVersion = "25.11";


 imports = [
    ./programs.nix
    ./mcpe-launcher.nix
    inputs.noctalia.homeModules.default
    ./mcpe-launcher-nvidia.nix
    ./helium.nix
];

home.packages = with pkgs; [
    bibata-cursors
     adw-gtk3
     dconf
  ];

#qt.style.package = with pkgs; [ darkly-qt5 darkly ];
#qt.platformTheme.name = "qt6ct";

#programs.spicetify = {
#    enable = true;
#    enabledExtensions = with spicePkgs.extensions; [
#      adblockify
#      hidePodcasts
#      shuffle
#    ];
#    theme = spicePkgs.themes.catppuccin;
#    colorScheme = "mocha";
#  };


  # Cursor (wirkt systemweit unter Wayland + XWayland)
  home.pointerCursor = {
    name = "Bibata-Modern-Classic";
    package = pkgs.bibata-cursors;
    size = 24;
    gtk.enable = true;
    x11.enable = true;
  };

  # Kitty Terminal
  programs.kitty.enable = true;
programs.kitty = {
  settings = {
    background_blur = 5;

  };
extraConfig = ''
    include themes/noctalia.conf
  '';
};  

  programs.noctalia-shell = {
     enable = true;
      plugins = {
        sources = [
          {
            enabled = true;
            name = "Official Noctalia Plugins";
            url = "https://github.com/noctalia-dev/noctalia-plugins";
          }
        ];
      };
      # this may also be a string or a path to a JSON file.
   };

}
