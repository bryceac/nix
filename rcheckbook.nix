{
	lib,
	libc,
	fetchFromGitHub,
	rustPlatform,
	llvmPackages,
	stdenv,
	makeWrapper,
}:

rustPlatform.buildRustPackage (finalAttrs: {
	pname = "rcheckbook";
	version = "0.6.6";

	src = fetchFromGitHub {
		owner = "bryceac";
		repo = "rcheckbook";
		rev = "v${finalAttrs.version}";
		sha256 = "1qyqwhhyykv917zvi2whp1y69lvlxj6mmn96fjac5g64aifds8rn";
	};

	postInstall = ''
		install -Dm644 -t $out/schema $src/register.sql
		wrapProgram $out/bin/rcheckbook --set REGISTRY_SCHEMA_DIR $out/schema
	'';

	cargoHash = "sha256-FtNVKrxgJM3j0UmbVc0th8A6xwKQMQSghryHgoEzPEk=";

	LIBCLANG_PATH = "${llvmPackages.libclang.lib}/lib";

	nativeBuildInputs = [ rustPlatform.bindgenHook makeWrapper ];

	meta = {
		description = "Simple CLI-based Checkbook ledger.";
		homepage = "https://github.com/bryceac/rcheckbook";
		license = lib.licenses.mit;
		maintainers = [];	
	};
})
