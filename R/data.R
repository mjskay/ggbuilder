#' @export
data_ = function(data) {
  structure(list(data = data), class = "ggbuilder_data")
}

#' @export
apply_builder.ggbuilder_data = function(layer_spec, x) {
  layer_spec$data = x$data
  layer_spec
}
