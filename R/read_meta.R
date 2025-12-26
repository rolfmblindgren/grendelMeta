read_meta <- function(path) {
  if (!file.exists(path)) {
    stop("Meta file not found: ", path)
  }
  yaml::read_yaml(path)
}
