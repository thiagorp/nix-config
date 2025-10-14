{
  lib,
  stdenv,
  fetchurl,
  nodejs,
  makeWrapper,
}:
stdenv.mkDerivation rec {
  pname = "codex";
  version = "0.46.0";

  src = fetchurl {
    url = "https://registry.npmjs.org/@openai/codex/-/codex-${version}.tgz";
    hash = "sha256-sh4LQvIvHEnqNFa5g8h7NQsQaIk3VC/ynm9NcgCNUSM=";
  };

  nativeBuildInputs = [makeWrapper];

  sourceRoot = "package";

  installPhase = ''
    runHook preInstall

    # Install the npm package
    mkdir -p $out/lib/node_modules/@openai/codex
    cp -r . $out/lib/node_modules/@openai/codex/

    # Create the binary wrapper
    mkdir -p $out/bin
    makeWrapper ${nodejs}/bin/node $out/bin/codex \
      --add-flags "$out/lib/node_modules/@openai/codex/bin/codex.js"

    runHook postInstall
  '';

  meta = with lib; {
    description = "Codex is an agentic coding tool that lives in your terminal";
    homepage = "https://github.com/openai/codex";
    license = licenses.mit;
    maintainers = [];
    platforms = platforms.all;
    mainProgram = "codex";
  };
}
