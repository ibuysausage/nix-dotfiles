{...}: {
  nixpkgs.overlays = [
    (final: prev: {
      python312 = prev.python312.overrideAttrs (old: {
        passthru =
          (old.passthru or {})
          // {
            doc = old.passthru.doc.overrideAttrs (docOld: {
              postPatch =
                (docOld.postPatch or "")
                + ''
                  # Support Docutils >= 0.22 in CPython's documentation.
                  substituteInPlace Doc/tools/extensions/pyspecific.py \
                    --replace-fail "from docutils.parsers.rst.states import Body" \
                    "def _disable_alphabetic_and_roman(text):
                      try:
                          from docutils.parsers.rst.states import InvalidRomanNumeralError
                          raise InvalidRomanNumeralError(text)
                      except ImportError:
                          return None

                  from docutils.parsers.rst.states import Body"

                  substituteInPlace Doc/tools/extensions/pyspecific.py \
                    --replace-fail "lambda x: None" "_disable_alphabetic_and_roman"

                  # Sphinx 9 uses "fragment", not "html_body".
                  substituteInPlace Doc/tools/extensions/glossary_search.py \
                    --replace-fail "rendered['html_body']" "rendered['fragment']"
                '';
            });
          };
      });
    })
  ];
}
