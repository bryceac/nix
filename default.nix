let
	nixpkgs = fetchTarball "https://github.com/NixOS/nixpkgs/tarball/nixos-26.05";
	pkgs = import nixpkgs { config = {}; overlays = []; };
in
{
	rcheckbook = pkgs.callPackage ./rcheckbook.nix {};
}
