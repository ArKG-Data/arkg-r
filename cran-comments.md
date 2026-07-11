## R CMD check results

0 errors | 0 warnings | 1 note

* This is a new release.

## Notes

* Possibly misspelled words in DESCRIPTION (ArKG, SPARQL,
  thermoluminescence) are technical terms and are spelled correctly.
* The package is a client for the ArKG SPARQL endpoint
  (<https://arkg.cl/api/sparql>), powered by MillenniumDB. The endpoint
  is stable.
* All examples that require network access are wrapped in \dontrun{}.
* Tests that require internet access use skip_on_cran() and
  skip_if_offline(), so they do not run on CRAN machines.
* The package does not write to the user filespace; any downloads
  default to tempdir().
* License is CC BY-SA 4.0, matching the license of the ArKG project
  data and documentation.

## Test environments

* Windows 10, R 4.4.2 (local)
* win-builder (R-devel)
* GitHub Actions:
  * ubuntu-latest: R-release, R-devel, R-oldrel-1
  * macos-latest: R-release
  * windows-latest: R-release

All environments passed with 0 errors and 0 warnings.