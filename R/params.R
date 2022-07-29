#' @export
params_ = function(...) {
  structure(list(params = list(...)), class = "ggbuilder_params")
}

#' @export
apply_builder.ggbuilder_params = function(layer_spec, x) {
  layer_spec$params = defaults(x$params, layer_spec$params)
  layer_spec
}
