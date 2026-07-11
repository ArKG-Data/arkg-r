#' Construir una peticion httr2 base para ArKG
#'
#' Crea una peticion con user-agent, reintentos, timeout y manejo de
#' errores centralizado. Funcion interna reutilizada por las demas.
#'
#' @param url URL de destino (por defecto el endpoint de ArKG).
#' @return Un objeto request de httr2.
#' @keywords internal
arkg_request <- function(url = arkg_endpoint()) {
  httr2::request(url) |>
    httr2::req_user_agent(arkg_user_agent()) |>
    httr2::req_retry(max_tries = 3) |>
    httr2::req_timeout(60) |>
    httr2::req_error(is_error = function(resp) httr2::resp_status(resp) >= 400)
}
