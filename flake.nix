{
  description = "Home Manager configuration of basile";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # ghostty = {
    #   url = "github:ghostty-org/ghostty";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
  };

  outputs =
    { nixpkgs, ghostty, home-manager, self, ... }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      homeConfigurations."basile" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [ 
          ./home.nix
          # ({ pkgs, ... }: {
          #   home.packages = [
          #     ghostty.packages.${system}.default
          #   ];
          # })
        ];
        extraSpecialArgs = { inherit self; };
      };
    };
}
