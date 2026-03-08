{ pkgs, inputs, ... }:

{
  imports = [
    # Hier ziehen wir die Logik direkt aus dem Flake-Input
   inputs.mango.nixosModules.mango
  ];

programs.mango = {
   enable = true;
};

}
