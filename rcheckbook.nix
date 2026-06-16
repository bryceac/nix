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
	version = "0.6.5";

	src = fetchFromGitHub {
		owner = "bryceac";
		repo = "rcheckbook";
		rev = "v${finalAttrs.version}";
		sha256 = "1ls32yacw9r7bl1sd00wagd0pg4viq9klmq3iyn0d2mnmgavc81s";
	};

	postInstall = ''
		install -Dm644 -t $out/schema $src/register.sql
		wrapProgram $out/bin/rcheckbook --set REGISTRY_SCHEMA_DIR $out/schema
	'';

	cargoHash = "sha256-ecmbjjgMIsVfWkQduotARDqJdXTdvPc2brophV5aCzw=";

	LIBCLANG_PATH = "${llvmPackages.libclang.lib}/lib";

	nativeBuildInputs = [ rustPlatform.bindgenHook ];

	meta = {
		description = "Simple CLI-based Checkbook ledger.";
		homepage = "https://github.com/bryceac/rcheckbook";
		license = lib.licenses.mit;
		maintainers = [];	
	};
})
