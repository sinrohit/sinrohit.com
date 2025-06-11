{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
    zine.url = "github:kristoff-it/zine";
  };

  outputs =
    inputs:
    inputs.flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [
        "aarch64-darwin"
        "aarch64-linux"
        "x86_64-linux"
      ];

      perSystem =
        {
          pkgs,
          system,
          self',
          ...
        }:
        {

          devShells.default = pkgs.mkShell {
            name = "zig-project-shell";
            meta.description = "Shell environment for Zig Project";
            packages = [
              inputs.zine.packages.${system}.zine
            ];
          };
        };
    };
}
