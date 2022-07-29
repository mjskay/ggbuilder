new_geom = function(geom, mapping = aes(), ..., .layer_spec = new_layer_spec()) {
  .layer_spec$geom = geom
  if (is.null(.layer_spec$stat)) {
    # no stat has been supplied to the layer, so use the geom's default stat
    # and apply the provided mapping before the stat, not after it.
    .layer_spec$mapping_stat = mapping
  } else {
    .layer_spec$mapping_geom = mapping
  }
  .layer_spec$params = defaults(list(...), .layer_spec$params)
  build_layer(.layer_spec)
}

#' @export
geom_ = function(x, ...) {
  UseMethod("geom_")
}

#' @export
geom_.character = function(x, ...) {
  new_geom(geom = x, ...)
}

#' @export
geom_.ggbuilder_layer = function(x, ...) {
  new_geom(..., .layer_spec = attr(x, "ggbuilder_layer_spec"))
}

#' @export
geom_.ggbuilder_layer_spec = function(x, ...) {
  new_geom(..., .layer_spec = x)
}

#' @export
geom_.ggbuilder_plot_data = function(x, ...) {
  new_geom(data = x$data, ...)
}
