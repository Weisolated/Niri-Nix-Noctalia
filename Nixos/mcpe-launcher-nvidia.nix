{ pkgs, ... }:

let
  mcpelauncherNvidia = pkgs.writeShellScriptBin "mcpelauncher-nvidia" ''
    exec flatpak run \
      --env=__NV_PRIME_RENDER_OFFLOAD=1 \
      --env=__GLX_VENDOR_LIBRARY_NAME=nvidia \
      --env=__VK_LAYER_NV_optimus=NVIDIA_only \
      io.mrarm.mcpelauncher
  '';
in {
  home.packages = [
    mcpelauncherNvidia
  ];

  xdg.desktopEntries.mcpelauncher-nvidia = {
    name = "Minecraft Bedrock (NVIDIA)";
    exec = "mcpelauncher-nvidia";
    terminal = false;
    categories = [ "Game" ];
    icon = "io.mrarm.mcpelauncher";
  };
}

