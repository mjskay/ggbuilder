#' @import ggplot2
#' @importFrom rlang expr
#' @export
layer_ = function(...) {
  layer_spec = layer_spec(...)
  params = layer_spec$params
  params$data = layer_spec$data

  # translate aesthetic mappings into a single aesthetic mapping with
  # appropriate calls to stage(), after_scale(), or after_stat()
  stat_aes_names = names(layer_spec$stat_mapping)
  geom_aes_names = names(layer_spec$geom_mapping)
  rescale_aes_names = names(layer_spec$rescale_mapping)
  aes_names = union(union(stat_aes_names, geom_aes_names), rescale_aes_names)
  params$mapping = lapply(aes_names, function(aes_name) {
    has_start = aes_name %in% stat_aes_names
    has_after_stat = aes_name %in% geom_aes_names
    has_after_scale = aes_name %in% rescale_aes_names

    # stage(after_stat = xxx) is seemingly not equivalent to after_stat(xxx)
    # so we'll enumerate the different combinations to figure out the necessary
    # function to call, though this is kinda ugly
    if (!has_start) {                                              # start | after_stat | after_scale |
      if (!has_after_stat) quo(
        after_scale(!!layer_spec$rescale_mapping[[aes_name]])      #       |            |    XXXX     |
      ) else if (has_after_scale) quo(stage(
        after_stat = !!layer_spec$stat_mapping[[aes_name]],        #       |    XXXX    |    XXXX     |
        after_scale = !!layer_spec$rescale_mapping[[aes_name]]
      )) else quo(
        after_stat(!!layer_spec$geom_mapping[[aes_name]])          #       |    XXXX    |             |
      )
    } else if (has_after_stat) {
      if (has_after_scale) quo(stage(
        !!layer_spec$stat_mapping[[aes_name]],                     # XXXX  |    XXXX    |    XXXX     |
        after_stat = !!layer_spec$stat_mapping[[aes_name]],
        after_scale = !!layer_spec$rescale_mapping[[aes_name]]
      ))
      else quo(stage(                                              # XXXX  |    XXXX    |             |
        !!layer_spec$stat_mapping[[aes_name]],
        after_stat = !!layer_spec$geom_mapping[[aes_name]]
      ))
    } else if (has_after_scale) quo(stage(
      !!layer_spec$stat_mapping[[aes_name]],                       # XXXX  |            |    XXXX     |
      after_scale = !!layer_spec$rescale_mapping[[aes_name]]
    )) else quo(
      !!layer_spec$stat_mapping[[aes_name]]                        # XXXX  |            |             |
    )
  })
  names(params$mapping) = aes_names
  class(params$mapping) = "uneval"

  do.call(layer_spec$fun, params)
}

new_layer_spec = function() {
  structure(list(
    data = NULL,
    params = list(),
    stat_mapping = aes(),
    geom_mapping = aes(),
    rescale_mapping = aes()
  ), class = "ggbuilder_layer_spec")
}

layer_spec = function(...) {
  builders = list(...)
  layer_spec = Reduce(apply_builder, c(list(new_layer_spec()), builders))

  if (!is.null(layer_spec$geom)) {
    layer_spec$fun = paste0("geom_", layer_spec$geom)
    layer_spec$params$stat = layer_spec$stat
  } else if (!is.null(layer_spec$stat)) {
    layer_spec$fun = paste0("stat_", layer_spec$stat)
  } else {
    stop0("Layers must have either a geom or a stat")
  }

  layer_spec
}


apply_builder = function(layer_spec, x) {
  UseMethod("apply_builder", x)
}


