final: prev:

let
  dbt-python = prev.python39.override {
    packageOverrides = pFinal: pPrev: {
      jinja2 = pPrev.jinja2.overridePythonAttrs (old: rec {
        version = "2.11.3";
        src = pPrev.fetchPypi {
          inherit (old) pname;
          inherit version;
          sha256 = "ptWEM94K6AA0fKsfowQ867q+i6qdKeZo8cdoy4ejM8Y=";
        };
      });

      cffi = pPrev.buildPythonPackage rec {
        pname = "cffi";
        version = "1.15.0";
        format = "wheel";
        src = builtins.fetchurl {
          # This patched wheel file comes from here:
          # https://github.com/dbt-labs/dbt-core/issues/3162#issuecomment-1011600708
          url =
            "https://files.pythonhosted.org/packages/3e/9b/660d6da900af1976a8b4efea713a7ce9e514bf4659eff9b17f90f00be1cf/cffi-1.15.0-cp39-cp39-macosx_11_0_arm64.whl";
          sha256 = "0dyys57ng6rqzshd475sv925dzpfk88mpkq41yk4jgvwkn6p1yri";
        };
        buildInputs = [ final.libffi ];
        propagatedBuildInputs = with pFinal; [ pycparser ];
      };
      oscrypto =
        pPrev.oscrypto.overridePythonAttrs (old: rec { doCheck = false; });

      snowflake-connector-python = pPrev.buildPythonPackage rec {
        pname = "snowflake-connector-python";
        version = "2.7.4";
        src = pPrev.fetchPypi {
          inherit pname version;
          sha256 =
            "12cf177bbc877ad025f5b00ef3779c4eebfdaf472e7912f87c2bcdc9f3864008";
        };
        propagatedBuildInputs = with pFinal; [
          certifi
          cffi
          cryptography
          idna
          keyring
          oscrypto
          pycryptodomex
          pyjwt
          pyopenssl
          pytz
          requests
        ];
      };

      dbt-extractor = pPrev.buildPythonPackage rec {
        pname = "dbt-extractor";
        version = "0.4.1";
        src = pPrev.fetchPypi {
          inherit version;
          pname = "dbt_extractor";
          sha256 =
            "75b1c665699ec0f1ffce1ba3d776f7dfce802156f22e70a7b9c8f0b4d7e80f42";
        };
        cargoDeps = final.rustPlatform.fetchCargoTarball {
          inherit src;
          name = "${pname}-${version}";
          hash = "sha256-rNvD7qmy/TJMC2sIBC9F/YNUsyLNvrK1hm0p8duuVLs=";
        };
        format = "pyproject";
        propagatedBuildInputs = [ final.libiconv ];
        nativeBuildInputs = with final.rustPlatform; [
          cargoSetupHook
          maturinBuildHook
        ];
      };

      cryptography_vectors = pPrev.cryptography_vectors.overridePythonAttrs
        (old: rec {
          pname = "cryptography_vectors";
          version = "3.4.8";
          src = pPrev.fetchPypi {
            inherit pname version;
            sha256 = "sha256-TIRBAleZPT3gWLRLd3pJ4doq416+opcKNgx+OqD1gPI=";
          };
        });

      cryptography = pPrev.cryptography.overridePythonAttrs (old: rec {
        version = "3.4.8";
        src = pPrev.fetchPypi {
          inherit (old) pname;
          inherit version;
          sha256 =
            "94cc5ed4ceaefcbe5bf38c8fba6a21fc1d365bb8fb826ea1688e3370b2e24a1c";
        };
        cargoDeps = final.rustPlatform.fetchCargoTarball {
          inherit src;
          sourceRoot = "${old.pname}-${version}/${old.cargoRoot}";
          name = "${old.pname}-${version}";
          sha256 = "sha256-9RxSRa8jzGgkHsvWzmHmZF2CaKjCGK5WlxsTamAIBQY=";
        };
      });

      hologram = pPrev.buildPythonPackage rec {
        pname = "hologram";
        version = "0.0.14";
        src = pPrev.fetchPypi {
          inherit pname version;
          sha256 =
            "fd67bd069e4681e1d2a447df976c65060d7a90fee7f6b84d133fd9958db074ec";
        };
        propagatedBuildInputs = with pFinal; [ jsonschema python-dateutil ];
        doCheck = false;
      };

      jsonschema = pPrev.buildPythonPackage rec {
        pname = "jsonschema";
        version = "3.1.1";
        src = pPrev.fetchPypi {
          inherit pname version;
          sha256 =
            "2fa0684276b6333ff3c0b1b27081f4b2305f0a36cf702a23db50edb141893c3f";
        };
        propagatedBuildInputs = with pFinal; [
          attrs
          importlib-metadata
          pyrsistent
        ];
        doCheck = false;
      };

      logbook = pPrev.buildPythonPackage rec {
        pname = "Logbook";
        version = "1.5.3";
        src = pPrev.fetchPypi {
          inherit pname version;
          sha256 =
            "66f454ada0f56eae43066f604a222b09893f98c1adc18df169710761b8f32fe8";
        };
        propagatedBuildInputs = with pFinal; [ ];
        doCheck = false;
      };

      mashumaro = pPrev.buildPythonPackage rec {
        pname = "mashumaro";
        version = "2.9";
        src = pPrev.fetchPypi {
          inherit pname version;
          sha256 =
            "343b6e2d3e432e31973688c4c8821dcd6ef41fd33264b992afc4aecbfd155f18";
        };
        propagatedBuildInputs = with pFinal; [
          msgpack
          pyyaml
          typing-extensions
        ];
      };

      minimal-snowplow-tracker = pPrev.buildPythonPackage rec {
        pname = "minimal-snowplow-tracker";
        version = "0.0.2";
        src = pPrev.fetchPypi {
          inherit pname version;
          sha256 =
            "acabf7572db0e7f5cbf6983d495eef54081f71be392330eb3aadb9ccb39daaa4";
        };
        propagatedBuildInputs = with pFinal; [ requests six ];
      };

      typing-extensions = pPrev.buildPythonPackage rec {
        pname = "typing-extensions";
        version = "3.10.0.2";
        src = pPrev.fetchPypi {
          inherit version;
          pname = "typing_extensions";
          sha256 =
            "49f75d16ff11f1cd258e1b988ccff82a3ca5570217d7ad8c5f48205dd99a677e";
        };
      };

      requests = pPrev.buildPythonPackage rec {
        pname = "requests";
        version = "2.27.1";
        src = pPrev.fetchPypi {
          inherit pname version;
          sha256 =
            "68d7c56fd5a8999887728ef304a6d12edc7be74f1cfa47714fc8b414525c9a61";
        };
        propagatedBuildInputs = with pFinal; [
          brotlipy
          charset-normalizer
          certifi
          idna
          urllib3
        ];
        doCheck = false;
      };

      dbt-snowflake = with pFinal;
        buildPythonPackage rec {
          pname = "dbt-snowflake";
          version = "1.0.0";
          src = fetchPypi {
            inherit pname version;
            sha256 =
              "a263274d6af430edfe33cf57b44c7eba58a73017ec8b1c82cb30b25e42be9a1c";
          };
          propagatedBuildInputs =
            [ cryptography dbt-core requests snowflake-connector-python ];
          doCheck = false;
        };

      dbt-core = with pFinal;
        pFinal.buildPythonPackage rec {
          pname = "dbt-core";
          version = "1.0.4";
          src = pFinal.fetchPypi {
            inherit pname version;
            sha256 =
              "e25cddcd210538133fd369816085179875d951b7b0af94be8c0966b85bf2b3be";
          };
          nativeBuildInputs = [ ];
          propagatedBuildInputs = with pFinal; [
            agate
            cffi
            click
            colorama
            dbt-extractor
            hologram
            jinja2
            logbook
            mashumaro
            minimal-snowplow-tracker
            networkx
            packaging
            sqlparse
            werkzeug
          ];
          doCheck = false;
        };
    };
  };

in rec {
  dbt = dbt-python.withPackages (ps: with ps; [ dbt-core dbt-snowflake ]);
}
