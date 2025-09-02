{
  description = "blepos — NixOS + Home Manager for Intel NUC";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; config.allowUnfree = true; };
    in {
      # NixOS host: nuc
      nixosConfigurations.nuc = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = { inherit inputs; }; # pass flake inputs if needed by modules
        modules = [
          ./hosts/nuc/configuration.nix
          # Home Manager as a NixOS module for system-wide integration
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.vince = import ./home/vince.nix;
          }
        ];
      };

      # Also expose a direct Home Manager config if you want to switch HM without full NixOS rebuild
      homeConfigurations."vince@nuc" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [ ./home/vince.nix ];
      };

      # Simpler alias (hostname-agnostic) for convenience on non-NixOS
      homeConfigurations."vince" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [ ./home/vince.nix ];
      };

      # Optional: a dev shell for working on this repo
      devShells.${system}.default = pkgs.mkShell {
        packages = with pkgs; [
          git
          nixfmt-rfc-style
        ];
      };
    };
}
