#' @export
geom_ = function(geom, mapping = NULL, ...) {
  out = params_(...)
  out$geom = geom
  out$mapping = mapping
  oldClass(out) = c("ggbuilder_geom", oldClass(out))
  out
}

#' @export
apply_builder.ggbuilder_geom = function(layer_spec, x) {
  layer_spec = NextMethod()
  layer_spec$geom = x$geom
  layer_spec$geom_mapping = x$mapping
  layer_spec
}
