{pkgs, ...}: {
  nixpkgs.overlays = [
    (final: prev: let
      # Override the Python used to build CPython's documentation.
      buildPython = prev.buildPackages.python3.override {
        self = buildPython;

        packageOverrides = pyFinal: pyPrev: {
          # Pin Docutils to a version that avoids the original
          # Python documentation build failure.
          docutils = pyPrev.docutils.overrideAttrs (old: rec {
            version = "0.21.2";

            src = prev.fetchurl {
              url = "mirror://sourceforge/docutils/docutils-${version}.tar.gz";
              hash = "sha256-OmsYcy7fGC2qPNEndbuzOM9WkUaPke7rEJ3v9uv6mG8=";
            };
          });

          # Pin Sphinx and work around incompatible patches and tests.
          sphinx = pyPrev.sphinx.overridePythonAttrs (old: rec {
            version = "8.2.3";

            src = old.src.overrideAttrs {
              tag = "v${version}";
              hash = "sha256-FoyCpDGDKNN2GMhE7gDpJLmWRWhbMCYlcVEaBTfXSEw=";
            };

            # Remove the patch that does not apply to Sphinx 8.2.3.
            patches =
              builtins.filter
              (patch:
                !(prev.lib.hasInfix "fix-test-stemmer" (toString patch)))
              (old.patches or []);

            postPatch =
              (old.postPatch or "")
              + ''
                substituteInPlace pyproject.toml \
                  --replace-fail "roman-numerals-py" "roman-numerals"
              '';

            # Skip only the test that fails under Python 3.14.
            disabledTests =
              (old.disabledTests or [])
              ++ [
                "test_coverage_ignore_pyobjects"
              ];
          });
        };
      };
    in {
      # Override the documentation build inputs for Python 3.12 only.
      python312 = prev.python312.overrideAttrs (old: {
        passthru =
          (old.passthru or {})
          // {
            doc = old.passthru.doc.overrideAttrs (docOld: {
              nativeBuildInputs = with buildPython.pkgs; [
                sphinxHook
                python-docs-theme
              ];
            });
          };
      });
    })
  ];
}
