{
  description = "NixOS Flake mit Noctalia + niri";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    noctalia = {
      url = "github:noctalia-dev/noctalia-shell";
      inputs.nixpkgs.follows = "nixpkgs"; # Korrigiert: hieß vorher nixpkgs-unstable
    };

  mango = {
    url = "github:mangowm/mango";
    inputs.nixpkgs.follows = "nixpkgs";
    };


  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs: {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      
      # Macht 'inputs' in allen Modulen (configuration.nix etc.) verfügbar
      specialArgs = { inherit inputs; };

      modules = [
        ./configuration.nix
        ./noctalia.nix # Hier kannst du inputs.noctalia nutze
	./mangowm.nix

	home-manager.nixosModules.home-manager
        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            backupFileExtension = "backup";
            
            # Das hier ersetzt das komplizierte 'import' von oben:
            extraSpecialArgs = { inherit inputs; };
            users.xxxxx = {
        imports = [
          ./home.nix
        ];
      };
          };
        }
      ];
    };
  };
}
