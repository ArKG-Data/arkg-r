test_that("sparql_to_tibble aplana un SELECT", {
  fake <- list(
    head = list(vars = list("s", "o")),
    results = list(bindings = list(
      list(s = list(type = "uri",     value = "http://ej/1"),
           o = list(type = "literal", value = "10")),
      list(s = list(type = "uri",     value = "http://ej/2"),
           o = list(type = "literal", value = "20"))
    ))
  )
  res <- sparql_to_tibble(fake)
  expect_s3_class(res, "tbl_df")
  expect_equal(nrow(res), 2L)
  expect_equal(names(res), c("s", "o"))
  expect_equal(res$o, c("10", "20"))
})

test_that("sparql_to_tibble maneja ASK", {
  expect_true(sparql_to_tibble(list(boolean = TRUE)))
  expect_false(sparql_to_tibble(list(boolean = FALSE)))
})

test_that("sparql_to_tibble maneja resultado vacio", {
  fake <- list(head = list(vars = list("s")),
               results = list(bindings = list()))
  res <- sparql_to_tibble(fake)
  expect_equal(nrow(res), 0L)
  expect_equal(names(res), "s")
})

test_that("arkg_clean quita prefijo y decodifica", {
  expect_equal(arkg_clean("https://arkg.cl/El-Mall%C3%ADn"), "El-Mallín")
  expect_equal(arkg_clean("Charred_material"), "Charred material")
  expect_true(is.na(arkg_clean(NA_character_)))
})