{ pkgs, inputs, ... }:

{
  imports = [
    # Hier ziehen wir die Logik direkt aus dem Flake-Input
    inputs.noctalia.nixosModules.default
  ];

environment.systemPackages = with pkgs; [
    inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default
    # ... maybe other stuff
  ];

  
  # Bonus für gpu-screen-recorder:
  # Er braucht oft spezielle Berechtigungen (setuid), um auf den Framebuffer zuzugreifen.
  # Manche Module machen das automatisch, ansonsten ist es gut zu wissen.
}
