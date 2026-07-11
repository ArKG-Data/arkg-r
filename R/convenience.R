#' Obtener las dataciones arqueologicas (Fechado) de ArKG
#'
#' Recupera los fechados arqueologicos (radiocarbono y termoluminiscencia)
#' del grafo ArKG, con sus atributos principales limpios y tipados.
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
  d$id       <- arkg_clean(d$fechado)
  d$site     <- arkg_clean(d$site)
  d$material <- arkg_clean(d$material)
  d$c14_type <- arkg_clean(d$c14_type)
  d$c14_age  <- suppressWarnings(as.numeric(d$c14_age))
  d$sd       <- suppressWarnings(as.numeric(d$sd))
  d
}

#' Listar sitios arqueologicos (ArchSite) de ArKG
#'
#' Recupera los sitios arqueologicos del grafo ArKG con sus coordenadas.
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
  s$id <- arkg_clean(s$site)
  s$x  <- suppressWarnings(as.numeric(s$x))
  s$y  <- suppressWarnings(as.numeric(s$y))
  s
}