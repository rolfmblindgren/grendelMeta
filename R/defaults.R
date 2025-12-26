apply_defaults <- function(meta) {
  stopifnot(is.list(meta))

  meta$locale    <- meta$locale    %||% "nb_NO"
  meta$site_name <- meta$site_name %||% "Grendel"

  meta
}
