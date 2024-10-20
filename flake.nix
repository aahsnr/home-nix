{
  description = "Home Manager configuration of ahsan";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    hyprland.url = "github:hyprwm/Hyprland/";
    hyprland-contrib.url = "github:hyprwm/contrib";
    hyprland-plugins.url = "github:hyprwm/hyprland-plugins";
    matugen.url = "github:InioX/matugen";
    yazi.url = "github:sxyazi/yazi";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    ags = {
      url = "github:Aylur/ags";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };

  outputs = { nixpkgs, home-manager, ags, self, ... }:
    let
      inputs = self.inputs;
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      hmModule = inputs.home-manager.nixosModules.home-manager;
      home-manager = {
        useUserPackages = true;
        useGlobalPkgs = true;
        extraSpecialArgs = {
          inherit inputs;
          inherit self;
        };
      users.ahsan = import ./home;
      };

    in {
      homeConfigurations."ahsan" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        modules = [  
          hmModule
          {inherit home-manager;}
          {
            home.packages = [
              ags.packages.${system}.default
            ];
          
          }
        ];
        specialArgs = {inherit inputs;};
        # Optionally use extraSpecialArgs
        # to pass through arguments to home.nix
      };
    };
}
