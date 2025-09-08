{
  lib,
  stdenv,
  fetchurl,
  nodejs,
  makeWrapper,
}:
stdenv.mkDerivation rec {
  pname = "claude-code";
  version = "1.0.108";

  src = fetchurl {
    url = "https://registry.npmjs.org/@anthropic-ai/claude-code/-/claude-code-${version}.tgz";
    hash = "sha256-AzGfHZ4nU5YiZxbWwgYvgIOznV7A4axWvUMfilDAh7o=";
  };

  nativeBuildInputs = [makeWrapper];

  sourceRoot = "package";

  installPhase = ''
    runHook preInstall

    # Install the npm package
    mkdir -p $out/lib/node_modules/@anthropic-ai/claude-code
    cp -r . $out/lib/node_modules/@anthropic-ai/claude-code/

    # Create the binary wrapper
    mkdir -p $out/bin
    makeWrapper ${nodejs}/bin/node $out/bin/claude \
      --add-flags "$out/lib/node_modules/@anthropic-ai/claude-code/cli.js"

    runHook postInstall
  '';

  meta = with lib; {
    description = "Claude Code is an agentic coding tool that lives in your terminal";
    homepage = "https://www.anthropic.com/claude-code";
    license = licenses.mit;
    maintainers = [];
    platforms = platforms.all;
    mainProgram = "claude-code";
  };
}
