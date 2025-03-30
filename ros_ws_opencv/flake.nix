{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    {
      self,
      nixpkgs,
      flake-utils,
    }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = import nixpkgs { inherit system; };
        opencvGtk = pkgs.opencv.override (old: {
          enableGtk2 = true;
        });
      in
      {
        devShells.default = pkgs.mkShell {
          packages = with pkgs; [
            cmake
            rustc
            cargo
            (if stdenv.isDarwin then opencv else opencvGtk)
          ];
          nativeBuildInputs = with pkgs; [
            pkg-config
          ];
          shellHook = ''
            echo "Entering devShell"

            export LIBCLANG_PATH="${pkgs.llvmPackages.libclang.lib}/lib"

            export C_INCLUDE_PATH="${pkgs.llvmPackages.libclang.lib}/lib/clang/19/include/"
            export CPLUS_INCLUDE_PATH="${pkgs.llvmPackages.libclang.lib}/lib/clang/19/include/"
            export CPATH="${pkgs.llvmPackages.libclang.lib}/lib/clang/19/include/"

            export C="${pkgs.clang}/bin/clang"
            export CXX="${pkgs.clang}/bin/clang++"

            echo "Nix development environment loaded!"
          '';
        };
      }
    );
}
