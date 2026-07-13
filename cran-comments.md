## Resubmission

This is a resubmission addressing the reviewer feedback.

* The reviewer reported a "possibly invalid URL" for
  https://arkg.cl/api/sparql (Status: 400) in NEWS.md. This is a SPARQL
  API endpoint that returns 400 when accessed without a query parameter,
  which is expected behaviour, not a broken link. To avoid the
  false-positive, the reference in NEWS.md now uses the base project URL
  (https://arkg.cl). The endpoint remains only in the package code.

## R CMD check results

0 errors | 0 warnings | 1 note

* This is a new release.
* Possibly misspelled words in DESCRIPTION (ArKG, SPARQL,
  thermoluminescence) are technical terms and are spelled correctly.
* The package is a client for the ArKG SPARQL endpoint, powered by
  MillenniumDB. The endpoint is stable.
* All examples that require network access are wrapped in \dontrun{}.
* Tests that require internet access use skip_on_cran() and
  skip_if_offline().
* The package does not write to the user filespace; downloads default
  to tempdir().
* License is CC BY-SA 4.0, matching the ArKG project data and docs.

## Test environments

* Windows, R 4.5.3 (local)
* win-builder (R-devel)
* GitHub Actions: ubuntu (release, devel, oldrel-1), macos, windows