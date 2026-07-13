# Salta el test si el endpoint de ArKG no responde (no solo si no hay internet).
skip_if_arkg_down <- function() {
  testthat::skip_on_cran()
  testthat::skip_if_offline()
  ok <- tryCatch({
    arkg_request(arkg_endpoint()) |>
      httr2::req_timeout(10) |>
      httr2::req_headers(Accept = "application/sparql-results+json") |>
      httr2::req_body_form(query = "ASK { ?s ?p ?o }") |>
      httr2::req_perform()
    TRUE
  }, error = function(e) FALSE)
  if (!ok) testthat::skip("El endpoint de ArKG no esta disponible.")
}