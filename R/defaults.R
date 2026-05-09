env_or_null <- function(name) {
  value <- Sys.getenv(name, unset = "")
  if (!nzchar(value)) {
    return(NULL)
  }
  value
}

apply_defaults <- function(meta) {
  stopifnot(is.list(meta))

  meta$locale           <- meta$locale           %||% "en_US"
  meta$robots           <- meta$robots           %||% "index,follow,max-image-preview:large,max-snippet:-1,max-video-preview:-1"
  meta$twitter_card     <- meta$twitter_card     %||% "summary_large_image"
  meta$twitter_site     <- meta$twitter_site     %||% env_or_null("SHINYSEO_TWITTER_SITE")
  meta$twitter_creator  <- meta$twitter_creator  %||% env_or_null("SHINYSEO_TWITTER_CREATOR")
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
