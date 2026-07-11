#' Ejecutar una consulta SPARQL en ArKG
#'
#' Envia una consulta SPARQL al endpoint de ArKG (MillenniumDB) mediante
#' POST y devuelve los resultados como tibble (para SELECT) o logico (ASK).
#'
#' @param query Cadena de texto con la consulta SPARQL.
#' @param endpoint URL del endpoint (por defecto arkg_endpoint())..
#' @return Un `tibble` para consultas SELECT, o `logical` para ASK.
#' @export
#' @examples
#' \dontrun{
#' arkg_sparql("SELECT * WHERE { ?s ?p ?o } LIMIT 5")
#' }
arkg_sparql <- function(query, endpoint = arkg_endpoint()) {
  stopifnot(is.character(query), length(query) == 1L)
  resp <- arkg_request(endpoint) |>
    httr2::req_headers(Accept = "application/sparql-results+json") |>
    httr2::req_body_form(query = query) |>
    httr2::req_perform()
  body <- httr2::resp_body_string(resp)
  sparql_to_tibble(jsonlite::fromJSON(body, simplifyVector = FALSE))
}

#' Convertir SPARQL Results JSON a tibble
#'
#' Implementa el formato "SPARQL 1.1 Query Results JSON".
#'
#' @param parsed Lista resultante de parsear el JSON de respuesta.
#' @return Un `tibble` (SELECT) o `logical` (ASK).
#' @keywords internal
sparql_to_tibble <- function(parsed) {
  if (!is.null(parsed$boolean)) {
    return(isTRUE(parsed$boolean))
  }
  vars <- unlist(parsed$head$vars)
  bindings <- parsed$results$bindings
  if (length(bindings) == 0L) {
    empty <- stats::setNames(
      rep(list(character(0)), length(vars)), vars
    )
    return(tibble::as_tibble(empty))
  }
  cols <- lapply(vars, function(v) {
    vapply(bindings, function(row) {
      cell <- row[[v]]
      if (is.null(cell)) NA_character_ else as.character(cell$value)
    }, character(1))
  })
  names(cols) <- vars
  tibble::as_tibble(cols)
}

#' Limpiar URIs de ArKG
#'
#' Quita el prefijo `https://arkg.cl/`, reemplaza guiones bajos por
#' espacios y decodifica caracteres URL-encoded.
#'
#' @param x Vector de caracteres a limpiar.
#' @return Vector de caracteres limpio.
#' @keywords internal
arkg_clean <- function(x) {
  x <- sub("https://arkg.cl/", "", x, fixed = TRUE)
  x <- gsub("_", " ", x)
  vapply(
    x,
    function(s) if (is.na(s)) NA_character_ else utils::URLdecode(s),
    character(1),
    USE.NAMES = FALSE
  )
}
