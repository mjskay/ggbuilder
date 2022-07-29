#' A Data Flow Pipeline Approach to Building ggplot2 Layers
#'
#' @docType package
#' @name ggbuilder-package
#' @aliases ggbuilder
#'
#' @description
#'
#' \pkg{ggbuilder} provides a pipeline-based approach for building individual
#' \pkg{ggplot2} layers, analogous to \pkg{dplyr}-like data transformation pipelines.
#'
#' @details
#'
#' As an alternative to \pkg{ggplot2} functions for controlling aesthetic evaluation
#' like [stage()], \pkg{ggbuilder} allows you to use function piping (i.e. [`|>`])
#' to chain data transformations, [ggplot2::Stat]s, and [ggplot2::Geom]s together
#' in order to construct layers.
#'
#' - See [geom_()] and [stat_()] for how to construct and chain geoms and stats
#'   using \pkg{ggbuilder}
#'
#' - See [plot_data()] for how to add data transformations into a layer definition
#'
#' - See [remap()] for how to apply transformations to aesthetics after scales
#'   have been calculated (analogous to [ggplot2::after_scale()]).
#'
NULL
