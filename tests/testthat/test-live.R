test_that("arkg_dates devuelve un tibble en vivo", {
  skip_if_arkg_down()
  d <- arkg_dates(limit = 5)
  expect_s3_class(d, "tbl_df")
  expect_true(nrow(d) > 0)
  expect_true(is.numeric(d$c14_age))
})

test_that("arkg_sites devuelve un tibble en vivo", {
  skip_if_arkg_down()
  s <- arkg_sites(limit = 3)
  expect_s3_class(s, "tbl_df")
  expect_true(is.numeric(s$x))
})