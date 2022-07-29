#' @export
rescale_ = function(mapping = NULL) {
  structure(list(mapping = mapping), class = "ggbuilder_rescale")
}

#' @export
apply_builder.ggbuilder_rescale = function(layer_spec, x) {
  layer_spec$rescale_mapping = defaults(x$mapping, layer_spec$rescale_mapping)
  layer_spec
}
