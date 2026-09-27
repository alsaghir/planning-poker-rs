{
  description = "Rust test";

  inputs.nix-config.url = "path:/home/ahmed/Projects/nix-config";
  inputs.nixpkgs.follows = "nix-config/nixpkgs";

  outputs =
    {
      self,
      nixpkgs,
      nix-config,
      ...
    }:
    let
      system = "x86_64-linux";
    in
    {
      devShells.${system}.default = nix-config.devShells.${system}.dioxus;
    };
}
