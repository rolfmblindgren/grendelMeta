test_that("social_meta builds metadata head tags", {
  tags <- social_meta(list(
    title = "Example app",
    description = "Short app description.",
    url = "https://example.no",
    image = "https://example.no/share.png"
  ))

  html <- htmltools::renderTags(tags)$head

  expect_match(html, "<title>Example app</title>", fixed = TRUE)
  expect_match(html, "rel=\"canonical\"", fixed = TRUE)
  expect_match(html, "property=\"og:title\" content=\"Example app\"", fixed = TRUE)
  expect_match(html, "name=\"twitter:card\" content=\"summary_large_image\"", fixed = TRUE)
  expect_match(html, "application/ld\\+json")
  expect_false(grepl("og:site_name", html, fixed = TRUE))
  expect_false(grepl("applicationCategory", html, fixed = TRUE))
})

test_that("social_meta can read YAML files", {
  path <- tempfile(fileext = ".yml")
  yaml::write_yaml(list(
    title = "From YAML",
    description = "Loaded from a file.",
    url = "https://example.no",
    image = "https://example.no/share.png"
  ), path)

  html <- htmltools::renderTags(social_meta(path))$head

  expect_match(html, "From YAML", fixed = TRUE)
})

test_that("social_meta validates required fields", {
  expect_error(
    social_meta(list(title = "Only title")),
    "Missing required meta fields"
  )
})

test_that("schema can be disabled", {
  html <- htmltools::renderTags(social_meta(list(
    title = "No schema",
    description = "Short app description.",
    url = "https://example.no",
    image = "https://example.no/share.png",
    schema = FALSE
  )))$head

  expect_false(grepl("application/ld\\+json", html))
})

# Local Variables:
# mode: R
# End:
