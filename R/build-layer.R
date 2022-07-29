#' @import ggplot2
#' @importFrom rlang expr
#' @export
build_layer = function(x) {
  UseMethod("build_layer")
}

build_layer.ggbuilder_layer = function(x) {
  build_layer(attr(x, "ggbuilder_layer_spec"))
}

build_layer.ggbuilder_layer_spec = function(x) {
  params = x$params

  if (!is.null(x$geom)) {
    fun = paste0("geom_", x$geom)
    if (!is.null(x$stat)) {
      params$stat = x$stat
    }
  } else if (!is.null(x$stat)) {
    fun = paste0("stat_", x$stat)
  } else {
    stop0("Layers must have either a geom or a stat")
  }

  # translate aesthetic mappings into a single aesthetic mapping with
  # appropriate calls to stage(), after_scale(), or after_stat()
  stat_aes_names = names(x$mapping_stat)
  geom_aes_names = names(x$mapping_geom)
  rescale_aes_names = names(x$mapping_final)
  aes_names = union(union(stat_aes_names, geom_aes_names), rescale_aes_names)
  params$mapping = lapply(aes_names, function(aes_name) {
    has_start = aes_name %in% stat_aes_names
    has_after_stat = aes_name %in% geom_aes_names
    has_after_scale = aes_name %in% rescale_aes_names

    # stage(after_stat = xxx) is seemingly not equivalent to after_stat(xxx)
    # so we'll enumerate the different combinations to figure out the necessary
    # function to call, though this is kinda ugly
    if (!has_start) {                                     # start | after_stat | after_scale |
      if (!has_after_stat) quo(
        after_scale(!!x$mapping_final[[aes_name]])        #       |            |    XXXX     |
      ) else if (has_after_scale) quo(stage(
        after_stat = !!x$mapping_geom[[aes_name]],        #       |    XXXX    |    XXXX     |
        after_scale = !!x$mapping_final[[aes_name]]
      )) else quo(
        after_stat(!!x$mapping_geom[[aes_name]])          #       |    XXXX    |             |
      )
    } else if (has_after_stat) {
      if (has_after_scale) quo(stage(
        !!x$mapping_stat[[aes_name]],                     # XXXX  |    XXXX    |    XXXX     |
        after_stat = !!x$mapping_geom[[aes_name]],
        after_scale = !!x$mapping_final[[aes_name]]
      ))
      else quo(stage(
        !!x$mapping_stat[[aes_name]],                     # XXXX  |    XXXX    |             |
        after_stat = !!x$mapping_geom[[aes_name]]
      ))
    } else if (has_after_scale) quo(stage(
      !!x$mapping_stat[[aes_name]],                       # XXXX  |            |    XXXX     |
      after_scale = !!x$mapping_final[[aes_name]]
    )) else quo(
      !!x$mapping_stat[[aes_name]]                        # XXXX  |            |             |
    )
  })
  names(params$mapping) = aes_names
  class(params$mapping) = "uneval"

  out = do.call(fun, params)
  oldClass(out) = c("ggbuilder_layer", oldClass(out))
  attr(out, "ggbuilder_layer_spec") = x
  out
}
