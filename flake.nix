{
  description = "My Home Manager Config";

  inputs = {
    # nixpkgs-unstable
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    # home-manager master 分支
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      ...
    }:
    let
      system = "x86_64-linux"; # Arch 大概率是这个
      pkgs = import nixpkgs { inherit system; };
    in
    {
      homeConfigurations.falser = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [
          ./home.nix
        ];
      };
    };
}
