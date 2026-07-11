# Helper interno: aplica una funcion a una columna solo si existe
apply_if_present <- function(df, col, fn) {
  if (!is.null(df[[col]])) df[[col]] <- fn(df[[col]])
  df
}

#' Obtener las dataciones arqueologicas (Fechado) de ArKG
#'
#' Recupera los fechados arqueologicos (radiocarbono y termoluminiscencia)
#' del grafo ArKG. Las consultas usan OPTIONAL y el post-procesado es
#' defensivo: si la ontologia cambia y algun predicado desaparece, la
#' columna correspondiente se devuelve vacia en lugar de producir un error.
#'
#' @param limit Numero maximo de filas a devolver (NULL = todas).
#' @return Un `tibble` con las dataciones. Columnas: fechado, label, site,
#'   material, method, c14_age, c14_type, sd, source, id.
#' @export
#' @examples
#' \dontrun{
#' arkg_dates(limit = 100)
#' }
arkg_dates <- function(limit = 100) {
  lim <- if (is.null(limit)) "" else sprintf("LIMIT %d", as.integer(limit))
  q <- sprintf('
PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
PREFIX wdt:  <http://www.wikidata.org/prop/direct/>
PREFIX :     <https://arkg.cl/>
SELECT DISTINCT ?fechado ?label ?site ?material ?method ?c14_age ?c14_type ?sd ?source
WHERE {
  ?fechado a :Fechado .
  OPTIONAL { ?fechado rdfs:label     ?label }
  OPTIONAL { ?fechado wdt:P9047      ?site }
  OPTIONAL { ?fechado wdt:P186       ?material }
  OPTIONAL { ?fechado :dating_method ?method }
  OPTIONAL { ?fechado :14C_age       ?c14_age }
  OPTIONAL { ?fechado :14C_type      ?c14_type }
  OPTIONAL { ?fechado :sd            ?sd }
  OPTIONAL { ?fechado wdt:P1343      ?source }
} %s', lim)
  d <- arkg_sparql(q)
  if (nrow(d) == 0L) return(d)
  if (!is.null(d$fechado)) d$id <- arkg_clean(d$fechado)
  d <- apply_if_present(d, "site",     arkg_clean)
  d <- apply_if_present(d, "material", arkg_clean)
  d <- apply_if_present(d, "c14_type", arkg_clean)
  d <- apply_if_present(d, "c14_age",  function(x) suppressWarnings(as.numeric(x)))
  d <- apply_if_present(d, "sd",       function(x) suppressWarnings(as.numeric(x)))
  d
}

#' Listar sitios arqueologicos (ArchSite) de ArKG
#'
#' Recupera los sitios arqueologicos del grafo ArKG con sus coordenadas.
#' El post-procesado es defensivo ante cambios de la ontologia.
#'
#' @param limit Numero maximo de filas a devolver (NULL = todas).
#' @return Un `tibble` con los sitios. Columnas: site, label, x, y, id.
#' @export
#' @examples
#' \dontrun{
#' arkg_sites()
#' }
arkg_sites <- function(limit = 100) {
  lim <- if (is.null(limit)) "" else sprintf("LIMIT %d", as.integer(limit))
  q <- sprintf('
PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
PREFIX :     <https://arkg.cl/>
SELECT DISTINCT ?site ?label ?x ?y WHERE {
  ?site a :ArchSite .
  OPTIONAL { ?site rdfs:label ?label }
  OPTIONAL { ?site :x ?x }
  OPTIONAL { ?site :y ?y }
} %s', lim)
  s <- arkg_sparql(q)
  if (nrow(s) == 0L) return(s)
  if (!is.null(s$site)) s$id <- arkg_clean(s$site)
  s <- apply_if_present(s, "x", function(x) suppressWarnings(as.numeric(x)))
  s <- apply_if_present(s, "y", function(x) suppressWarnings(as.numeric(x)))
  s
}