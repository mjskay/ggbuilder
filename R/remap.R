#' Remap aesthetics after scales are applied
#'
#' Add this to the end of a \pkg{ggbuilder} pipeline to remap layer aesthetics
#' after the scale functions have been applied. Analogous to [ggplot2::after_scale()].
#'
#' @param x One of:
#'   - A \pkg{ggbuilder} [layer]
#'   - A \pkg{ggbuilder} [layer_spec]
#' @param mapping Set of aesthetic mappings created by [aes()] or [aes_()].
#'
#' @returns
#' A \pkg{ggbuilder} [layer] with aesthetics provided in `mapping` applied after
#' scales are computed, using [ggplot2::after_scale()]
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
#' @name remap
NULL

new_remap = function(mapping, .layer_spec = new_layer_spec()) {
  .layer_spec$mapping_final = defaults(mapping, .layer_spec$mapping_final)
  new_layer(.layer_spec)
}

#' @rdname remap
#' @export
remap = function(x, mapping) {
  UseMethod("remap")
}

#' @rdname remap
#' @export
remap.ggbuilder_layer = function(x, mapping) {
  new_remap(mapping, .layer_spec = attr(x, "ggbuilder_layer_spec"))
}

#' @rdname remap
#' @export
remap.ggbuilder_layer_spec = function(x, mapping) {
  new_remap(mapping, .layer_spec = x)
}
