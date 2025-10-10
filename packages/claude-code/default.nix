{
  lib,
  stdenv,
  fetchurl,
  nodejs,
  makeWrapper,
}:
stdenv.mkDerivation rec {
  pname = "claude-code";
  version = "2.0.14";

  src = fetchurl {
    url = "https://registry.npmjs.org/@anthropic-ai/claude-code/-/claude-code-${version}.tgz";
    hash = "sha256-OKEBzHtxuiRtlRuIa/Bbo5Sa0/77DJjNCw1Ekw4tchk=";
  };

  nativeBuildInputs = [makeWrapper];

  sourceRoot = "package";

  installPhase = ''
    runHook preInstall

    # Install the npm package
    mkdir -p $out/lib/node_modules/@anthropic-ai/claude-code
    cp -r . $out/lib/node_modules/@anthropic-ai/claude-code/

    # Create the binary wrappers
    mkdir -p $out/bin
    # Default claude (safe mode with permission prompts)
    makeWrapper ${nodejs}/bin/node $out/bin/claude \
      --add-flags "$out/lib/node_modules/@anthropic-ai/claude-code/cli.js"

    # Safe claude (with permission prompts)
    makeWrapper ${nodejs}/bin/node $out/bin/safe-claude \
      --add-flags "$out/lib/node_modules/@anthropic-ai/claude-code/cli.js"

    # Explicit YOLO claude
    makeWrapper ${nodejs}/bin/node $out/bin/yolo-claude \
      --add-flags "$out/lib/node_modules/@anthropic-ai/claude-code/cli.js" \
      --add-flags "--dangerously-skip-permissions"

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
