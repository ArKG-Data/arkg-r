# arkg

<!-- badges: start -->
[![R-CMD-check](https://github.com/ArKG-Data/arkg-r/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/ArKG-Data/arkg-r/actions/workflows/R-CMD-check.yaml)
<!-- badges: end -->

Cliente de R para acceder al **Archaeology Knowledge Graph de Chile**
([ArKG](https://arkg.cl)), que organiza y distribuye de forma abierta las
dataciones arqueologicas de Chile (radiocarbono y termoluminiscencia)
usando el motor de grafos MillenniumDB.

## Instalacion

```r
# install.packages("remotes")
remotes::install_github("ArKG-Data/arkg-r")
```

## Uso

```r
library(arkg)

# Dataciones arqueologicas (Fechado)
dataciones <- arkg_dates(limit = 100)

# Sitios arqueologicos con coordenadas
sitios <- arkg_sites(limit = 50)

# Consulta SPARQL libre
arkg_sparql("SELECT (COUNT(*) AS ?n) WHERE { ?s ?p ?o }")
```

## Endpoint

Por defecto el paquete consulta `https://arkg.cl/api/sparql`.
Se puede cambiar con la variable de entorno `ARKG_SPARQL_ENDPOINT`.

## Datos

El grafo contiene dataciones (clase `Fechado`), sitios arqueologicos
(clase `ArchSite`) y entidades geograficas, enlazados con vocabulario
propio de ArKG y con Wikidata.

## Licencia

CC BY-SA 4.0

## Como citar

Campbell, R., Mendez, V., Arenas, M., Riveros, C. ArKG: Archaeology
Knowledge Graph of Chile. <https://arkg.cl>

Dataset: <https://zenodo.org/records/19673110>
