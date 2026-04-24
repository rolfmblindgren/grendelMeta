apply_defaults <- function(meta) {
  stopifnot(is.list(meta))

  meta$locale           <- meta$locale           %||% "en_US"
  meta$robots           <- meta$robots           %||% "index,follow,max-image-preview:large,max-snippet:-1,max-video-preview:-1"
  meta$twitter_card     <- meta$twitter_card     %||% "summary_large_image"
  meta$schema_type      <- meta$schema_type      %||% "WebApplication"
  meta$operating_system <- meta$operating_system %||% "Any"
  meta$author_type      <- meta$author_type      %||% "Person"
  meta$publisher_type   <- meta$publisher_type   %||% "Organization"
  meta$in_language      <- meta$in_language      %||% meta$locale

  meta
}

# Local Variables:
# mode: R
# End:
