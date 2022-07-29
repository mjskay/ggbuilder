#' @export
stat_ = function(stat, mapping = NULL, ...) {
  out = params_(...)
  out$stat = stat
  out$mapping = mapping
  oldClass(out) = c("ggbuilder_stat", oldClass(out))
  out
}

#' @export
apply_builder.ggbuilder_stat = function(layer_spec, x) {
  layer_spec = NextMethod()
  layer_spec$stat = x$stat
  layer_spec$stat_mapping = x$mapping
  layer_spec
}
