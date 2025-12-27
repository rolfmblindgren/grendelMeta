#' Inject social metadata into Shiny UI
#'
#' @param meta Either a path to a YAML file or a named list
#' @export
social_meta <- function(meta) {

  if (is.character(meta)) {
    meta <- read_meta(meta)
  }

  required <- c("title", "description", "url", "image")
  missing <- setdiff(required, names(meta))
  if (length(missing)) {
    stop("Missing required meta fields: ", paste(missing, collapse = ", "))
  }

  shiny::tags$head(
    shiny::tags$link(rel="canonical", href=meta$url),

    shiny::tags$meta(name="description", content=meta$description),
    shiny::tags$meta(name="robots", content="index,follow"),

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

    shiny::tags$meta(name="twitter:card", content="summary_large_image"),
    shiny::tags$meta(name="twitter:title", content=meta$title),
    shiny::tags$meta(name="twitter:description", content=meta$description),
    shiny::tags$meta(name="twitter:image", content=meta$image),
    shiny::tags$meta(name="twitter:url", content=meta$url),

    if (!is.null(meta$twitter_site))
      shiny::tags$meta(name="twitter:site", content=meta$twitter_site),

    if (!is.null(meta$twitter_creator))
      shiny::tags$meta(name="twitter:creator", content=meta$twitter_creator),

    shiny::tags$title(meta$title)
  )
}
