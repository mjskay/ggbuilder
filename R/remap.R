new_remap = function(mapping, .layer_spec = new_layer_spec()) {
  .layer_spec$mapping_final = defaults(mapping, .layer_spec$mapping_final)
  build_layer(.layer_spec)
}

#' @export
remap = function(x, mapping) {
  UseMethod("remap")
}

#' @export
remap.ggbuilder_layer = function(x, mapping) {
  new_remap(mapping, .layer_spec = attr(x, "ggbuilder_layer_spec"))
}

#' @export
remap.ggbuilder_layer_spec = function(x, mapping) {
  new_remap(mapping, .layer_spec = x)
}
