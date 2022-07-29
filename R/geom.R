#' Pipable ggplot2 geoms
#'
#' A [ggplot2::layer()] containing a [ggplot2::Geom]; intended for piping.
#'
#' @param x One of:
#'   - A string: The suffix of a `geom_XXX` function used to create this geom.
#'   - A \pkg{ggbuilder} [layer], [layer_spec], or [plot_data] object representing
#'     earlier data and data transformations used as input to this geom. In this
#'     case, the second argument should be the suffix of a `geom_XXX` function
#'     used to create this geom.
#' @param ... arguments passed on to the geom's constructor.
#'
#' @returns
#'
#' A \pkg{ggbuilder} [layer], which is also a [ggplot2::layer], and which can be
#' added to a [ggplot()] object or piped into other \pkg{ggbuilder} functions.
#'
#' @examples
#'
#' library(ggplot2)
#'
#' set.seed(123456)
#' df = data.frame(condition = c("A", "B", "C"), response = round(rnorm(30, 1:3), 1))
#'
#' df |>
#'   ggplot(aes(x = condition, y = response, color = condition)) +
#'   geom_boxplot() +
#'   stat_("boxplot", aes(y = response)) |>
#'     geom_("label", aes(y = ymax, label = ymax)) |>
#'     remap(aes(fill = scales::alpha(color, 0.1))) +
#'   theme_light()
#'
#' @import ggplot2
#' @importFrom rlang expr
#' @name geom_
NULL

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
  new_layer(.layer_spec)
}

#' @rdname geom_
#' @export
geom_ = function(x, ...) {
  UseMethod("geom_")
}

#' @rdname geom_
#' @export
geom_.character = function(x, ...) {
  new_geom(geom = x, ...)
}

#' @rdname geom_
#' @export
geom_.ggbuilder_layer = function(x, ...) {
  new_geom(..., .layer_spec = attr(x, "ggbuilder_layer_spec"))
}

#' @rdname geom_
#' @export
geom_.ggbuilder_layer_spec = function(x, ...) {
  new_geom(..., .layer_spec = x)
}

#' @rdname geom_
#' @export
geom_.ggbuilder_plot_data = function(x, ...) {
  new_geom(data = x$data, ...)
}
