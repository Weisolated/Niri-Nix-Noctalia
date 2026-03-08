{ ... }:

{
  xdg.desktopEntries.helium-browser = {
    name = "Helium Browser";
    exec = "appimage-run /home/xxxxx/AppImages/helium.appimage %U";
    terminal = false;
    categories = [ "Network" "WebBrowser" ];
    icon = "/home/xxxxx/AppImages/.icons/helium.png";
    type = "Application";
  };
}
