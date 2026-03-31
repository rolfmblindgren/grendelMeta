#' Inject social metadata into Shiny UI
#'
#' @param meta Either a path to a YAML file or a named list
#' @export
social_meta <- function(meta) {
  if (is.character(meta)) {
    meta <- read_meta(meta)
  }
  meta <- apply_defaults(meta)

  required <- c("title", "description", "url", "image")
  missing <- setdiff(required, names(meta))
  if (length(missing)) {
    stop("Missing required meta fields: ", paste(missing, collapse = ", "))
  }

  schema <- build_schema_meta(meta)

  shiny::tags$head(
    shiny::tags$link(rel="canonical", href=meta$url),

    shiny::tags$meta(name="description", content=meta$description),
    shiny::tags$meta(name="robots", content=meta$robots),

    shiny::tags$meta(property="og:type", content="website"),
    shiny::tags$meta(property="og:title", content=meta$title),
    shiny::tags$meta(property="og:description", content=meta$description),
    shiny::tags$meta(property="og:url", content=meta$url),
    shiny::tags$meta(property="og:image", content=meta$image),

    if (!is.null(meta$site_name))
      shiny::tags$meta(property="og:site_name", content=meta$site_name),

    if (!is.null(meta$locale))
      shiny::tags$meta(property="og:locale", content=meta$locale),

    if (!is.null(meta$image_width))
      shiny::tags$meta(property="og:image:width", content=as.character(meta$image_width)),

    if (!is.null(meta$image_height))
      shiny::tags$meta(property="og:image:height", content=as.character(meta$image_height)),

    if (!is.null(meta$image_type))
      shiny::tags$meta(property="og:image:type", content=meta$image_type),

    if (!is.null(meta$image_alt))
      shiny::tags$meta(property="og:image:alt", content=meta$image_alt),

    shiny::tags$meta(name="twitter:card", content=meta$twitter_card),
    shiny::tags$meta(name="twitter:title", content=meta$title),
    shiny::tags$meta(name="twitter:description", content=meta$description),
    shiny::tags$meta(name="twitter:image", content=meta$image),
    shiny::tags$meta(name="twitter:url", content=meta$url),

    if (!is.null(meta$twitter_site))
      shiny::tags$meta(name="twitter:site", content=meta$twitter_site),

    if (!is.null(meta$twitter_creator))
      shiny::tags$meta(name="twitter:creator", content=meta$twitter_creator),

    if (!is.null(meta$twitter_image_alt))
      shiny::tags$meta(name="twitter:image:alt", content=meta$twitter_image_alt),

    if (!is.null(schema))
      shiny::tags$script(
        type = "application/ld+json",
        shiny::HTML(jsonlite::toJSON(schema, auto_unbox = TRUE))
      ),

    shiny::tags$title(meta$title)
  )
}

build_schema_meta <- function(meta) {
  if (isFALSE(meta$schema)) {
    return(NULL)
  }

  schema <- list(
    "@context" = "https://schema.org",
    "@type" = meta$schema_type,
    name = meta$title,
    description = meta$description,
    url = meta$url,
    inLanguage = meta$in_language
  )

  if (!is.null(meta$application_category)) {
    schema$applicationCategory <- meta$application_category
  }

  if (!is.null(meta$operating_system)) {
    schema$operatingSystem <- meta$operating_system
  }

  if (!is.null(meta$educational_use)) {
    schema$educationalUse <- meta$educational_use
  }

  if (!is.null(meta$is_accessible_for_free)) {
    schema$isAccessibleForFree <- isTRUE(meta$is_accessible_for_free)
  }

  if (!is.null(meta$disclaimer)) {
    schema$disclaimer <- meta$disclaimer
  }

  if (!is.null(meta$author_name)) {
    schema$author <- list(
      "@type" = meta$author_type,
      name = meta$author_name
    )
  }

  if (!is.null(meta$publisher_name)) {
    schema$publisher <- list(
      "@type" = meta$publisher_type,
      name = meta$publisher_name
    )
  }

  schema
}
