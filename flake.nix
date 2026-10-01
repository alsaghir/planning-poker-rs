{
  description = "Planning Poker (Rust/Dioxus) — local-first clone";

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
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      # Base = the shared dioxus dev shell from nix-config, layered with this
      # project's own tooling (sqlx-cli, etc.). Anything Supabase/Postgres-specific
      # stays here, never in nix-config.
      devShells.${system}.default = pkgs.mkShell {
        inputsFrom = [ nix-config.devShells.${system}.dioxus ];
        packages = with pkgs; [
          sqlx-cli
        ];
      };
    };
}
