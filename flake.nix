{
  description = "Flake for the Neovim config files";

  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
    nixpkgs.url = "nixpkgs/nixos-25.05";
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
