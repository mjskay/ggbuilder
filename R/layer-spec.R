#' Pipable ggplot2 layer specifications
#'
#' A specification for a [ggplot2::layer] built from a [ggbuilder::layer_spec] and intended for
#' piping. Typically constructed using [geom_()] or [stat_()], not this function.
#'
#' @returns
#'
#' A ggbuilder [layer_spec] representing a layer to be constructed by [new_layer()].
#'
#' @examples
#'
#' # See geom_() or stat_() for examples; this function
#' # should not usually be used directly.
#'
#' @import ggplot2
#' @importFrom rlang expr
#' @name layer_spec
#' @export
new_layer_spec = function() {
  structure(list(
    params = list(),
    mapping_stat = aes(),
    mapping_geom = aes(),
    mapping_final = aes()
  ), class = "ggbuilder_layer_spec")
}


# printing ----------------------------------------------------------------

#' @export
print.ggbuilder_layer_spec = function(x, ...) {
  cat0("<ggbuilder::layer_spec>:\n")
  print(unclass(x), ...)
  invisible(x)
}
