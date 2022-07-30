#' Pipable ggplot2 stats
#'
#' A [ggplot2::stat] intended for piping.
#'
#' @param x One of:
#'   - A string: The suffix of a `stat_XXX` function used to create this stat.
#'   - A \pkg{ggbuilder} [layer], [layer_spec], or [plot_data] object representing
#'     earlier data and data transformations used as input to this stat. In this
#'     case, the second argument should be the suffix of a `stat_XXX` function
#'     used to create this stat.
#' @param ... arguments passed on to the stat's constructor.
#'
#' @details
#' `stat_()` can be used to replace typical `stat_XXX()` calls in \pkg{ggplot2}
#' code to make them pipable by using the `XXX` suffix as a string as the first
#' argument to `stat_()`.
#'
#' For example, `stat_boxplot(...)` would become `stat_("boxplot", ...)`.
#' The primary difference between the former and the latter is that the latter
#' is both a [ggplot2::layer] *and* a ggbuilder [layer] containing a [layer_spec].
#' The contained [layer_spec] stores information on how to construct the
#' stat, which allows it to be combined with other objects (e.g. by piping it
#' into `geom_()`) to construct more complex layers. See *Examples*.
#'
#' @returns
#' A ggbuilder [layer], which is also a [ggplot2::layer], and which can be
#' added to a [ggplot()] object or piped into other ggbuilder functions.
#'
#' @examples
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
#' @name stat_
NULL

new_stat = function(stat, mapping = aes(), ..., .layer_spec = new_layer_spec()) {
  if (!is.null(.layer_spec$geom)) {
    stop0("Cannot apply a stat_() to a <ggbuilder::layer_spec> that already has a geom_()")
  }
  .layer_spec$stat = stat
  .layer_spec$mapping_stat = mapping
  .layer_spec$params = defaults(list(...), .layer_spec$params)
  new_layer(.layer_spec)
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
