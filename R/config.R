#' Endpoint SPARQL de ArKG
#'
#' Devuelve la URL del endpoint SPARQL de ArKG. Se puede sobrescribir con
#' la variable de entorno `ARKG_SPARQL_ENDPOINT`.
#'
#' @return Cadena de caracteres con la URL del endpoint.
#' @export
#' @examples
#' arkg_endpoint()
arkg_endpoint <- function() {
  Sys.getenv("ARKG_SPARQL_ENDPOINT", unset = "https://arkg.cl/api/sparql")
}

#' User-agent del paquete arkg
#'
#' @return Cadena de caracteres para la cabecera User-Agent.
#' @keywords internal
arkg_user_agent <- function() {
  ver <- tryCatch(
    as.character(utils::packageVersion("arkg")),
    error = function(e) "dev"
  )
  paste0("arkg-r/", ver, " (+https://github.com/ArKG-Data/arkg-r)")
}
