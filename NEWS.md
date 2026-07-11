# arkg 0.1.0

* Primera versión.
* Cliente para el endpoint SPARQL de ArKG (<https://arkg.cl/api/sparql>).
* Funciones principales:
  * `arkg_sparql()`: ejecuta consultas SPARQL genéricas.
  * `arkg_dates()`: recupera dataciones arqueológicas (Fechado).
  * `arkg_sites()`: recupera sitios arqueológicos (ArchSite).
  * `arkg_endpoint()`: devuelve el endpoint (configurable mediante la
    variable de entorno `ARKG_SPARQL_ENDPOINT`).