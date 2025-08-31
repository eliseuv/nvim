{
  description = "Flake for the Neovim config files";

  nixConfig = {
    extra-substituters = [
      "https://cache.nixos.org"
      "https://nix-community.cachix.org"
    ];
    extra-trusted-public-keys = [
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
  };

  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
    nixpkgs.url = "nixpkgs/nixos-unstable";
  };

  outputs =
    {
      self,
      flake-utils,
      nixpkgs,
    }@inputs:

    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in
      {

        devShells.default = pkgs.mkShell {
          buildInputs = with pkgs; [

            # Lua
            lua51Packages.lua

            # LSP
            lua-language-server

            # Formatter
            stylua

            # Lua Rocks
            lua51Packages.luarocks

          ];

          shellHook = ''
            lua -v
          '';
        };

      }
    );

}
