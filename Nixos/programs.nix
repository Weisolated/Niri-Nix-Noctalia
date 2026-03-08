{ config, pkgs, ... }:

{

  home.packages = with pkgs; [
	adw-gtk3
	nwg-look
	kdePackages.qt6ct
	lutris
	goverlay
	heroic
	bitwarden-desktop
	joplin-desktop
	protonplus
	libreoffice-fresh
	onlyoffice-desktopeditors
	brave
	filen-desktop
	sushi
	prismlauncher
	vesktop
	pavucontrol
	fastfetch	
	gpu-screen-recorder
	gpu-screen-recorder-gtk
	librewolf
	gnome-clocks
	gnome-weather
	gnome-calendar
	gnome-calculator
	gnome-disk-utility
	papers
	loupe
	bazaar
	gnome-text-editor
	faugus-launcher
	spicetify-cli
	yazi
	tree
	kdePackages.dolphin
	komikku
];
}
