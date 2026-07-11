test_that("arkg_endpoint respeta variable de entorno", {
  withr::with_envvar(c(ARKG_SPARQL_ENDPOINT = "https://ejemplo.test/sparql"), {
    expect_equal(arkg_endpoint(), "https://ejemplo.test/sparql")
  })
})

test_that("arkg_endpoint tiene valor por defecto", {
  withr::with_envvar(c(ARKG_SPARQL_ENDPOINT = ""), {
    expect_equal(arkg_endpoint(), "https://arkg.cl/api/sparql")
  })
})