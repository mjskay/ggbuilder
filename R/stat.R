new_stat = function(stat, mapping = aes(), ..., .layer_spec = new_layer_spec()) {
  if (!is.null(.layer_spec$geom)) {
    stop0("Cannot apply a stat_() to a <ggbuilder::layer_spec> that already has a geom_()")
  }
  .layer_spec$stat = stat
  .layer_spec$mapping_stat = mapping
  .layer_spec$params = defaults(list(...), .layer_spec$params)
  build_layer(.layer_spec)
}

#' @export
stat_ = function(x, ...) {
  UseMethod("stat_")
}

#' @export
stat_.character = function(x, ...) {
  new_stat(stat = x, ...)
}

#' @export
stat_.ggbuilder_layer = function(x, ...) {
  new_stat(..., .layer_spec = attr(x, "ggbuilder_layer_spec"))
}

#' @export
stat_.ggbuilder_layer_spec = function(x, ...) {
  new_stat(..., .layer_spec = x)
}

#' @export
stat_.ggbuilder_plot_data = function(x, ...) {
  new_stat(data = x$data, ...)
}
