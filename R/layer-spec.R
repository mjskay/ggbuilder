new_layer_spec = function() {
  structure(list(
    data = NULL,
    params = list(),
    mapping_stat = aes(),
    mapping_geom = aes(),
    mapping_final = aes()
  ), class = "ggbuilder_layer_spec")
}


# printing ----------------------------------------------------------------

#' @export
print.ggbuilder_layer_spec = function(x, ...) {
  cat0("<ggbuilder::layer_spec>:\n")
  print(unclass(x), ...)
  invisible(x)
}
