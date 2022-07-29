# Implementations of lazy dplyr / tidyr verbs for plot_data()


# sequences of lazy operations on plot data -------------------------------

plot_data_sequence = function(data, fun, ...) {
  UseMethod("plot_data_sequence")
}

#' @export
plot_data_sequence.NULL = function(data, fun, ...) {
  plot_data(function(x) fun(x, ...))
}

#' @export
plot_data_sequence.data.frame = function(data, fun, ...) {
  plot_data(fun(data, ...))
}

#' @export
plot_data_sequence.function = function(data, fun, ...) {
  plot_data(function(x) fun(data(x), ...))
}


# dplyr verbs -------------------------------------------------------------

#' @exportS3Method dplyr::arrange
arrange.ggbuilder_plot_data = function(.data, ...) {
  plot_data_sequence(.data$data, dplyr::arrange, ...)
}

#' @exportS3Method dplyr::count
count.ggbuilder_plot_data = function(x, ...) {
  plot_data_sequence(x$data, dplyr::count, ...)
}

#' @exportS3Method dplyr::distinct
distinct.ggbuilder_plot_data = function(.data, ...) {
  plot_data_sequence(.data$data, dplyr::distinct, ...)
}

#' @exportS3Method dplyr::do
do.ggbuilder_plot_data = function(.data, ...) {
  plot_data_sequence(.data$data, dplyr::do, ...)
}

#' @exportS3Method dplyr::filter
filter.ggbuilder_plot_data = function(.data, ...) {
  plot_data_sequence(.data$data, dplyr::filter, ...)
}

#' @exportS3Method dplyr::group_by
group_by.ggbuilder_plot_data = function(.data, ...) {
  plot_data_sequence(.data$data, dplyr::group_by, ...)
}

#' @exportS3Method dplyr::inner_join
inner_join.ggbuilder_plot_data = function(x, ...) {
  plot_data_sequence(x$data, dplyr::inner_join, ...)
}

#' @exportS3Method dplyr::left_join
left_join.ggbuilder_plot_data = function(x, ...) {
  plot_data_sequence(x$data, dplyr::left_join, ...)
}

#' @exportS3Method dplyr::right_join
right_join.ggbuilder_plot_data = function(x, ...) {
  plot_data_sequence(x$data, dplyr::right_join, ...)
}

#' @exportS3Method dplyr::full_join
full_join.ggbuilder_plot_data = function(x, ...) {
  plot_data_sequence(x$data, dplyr::full_join, ...)
}

#' @exportS3Method dplyr::mutate
mutate.ggbuilder_plot_data = function(.data, ...) {
  plot_data_sequence(.data$data, dplyr::mutate, ...)
}

#' @exportS3Method dplyr::transmute
transmute.ggbuilder_plot_data = function(.data, ...) {
  plot_data_sequence(.data$data, dplyr::transmute, ...)
}

#' @exportS3Method dplyr::pull
pull.ggbuilder_plot_data = function(.data, ...) {
  plot_data_sequence(.data$data, dplyr::pull, ...)
}

#' @exportS3Method dplyr::select
select.ggbuilder_plot_data = function(.data, ...) {
  plot_data_sequence(.data$data, dplyr::select, ...)
}

#' @exportS3Method dplyr::slice
slice.ggbuilder_plot_data = function(.data, ...) {
  plot_data_sequence(.data$data, dplyr::slice, ...)
}

#' @exportS3Method dplyr::slice_head
slice_head.ggbuilder_plot_data = function(.data, ...) {
  plot_data_sequence(.data$data, dplyr::slice_head, ...)
}

#' @exportS3Method dplyr::slice_tail
slice_tail.ggbuilder_plot_data = function(.data, ...) {
  plot_data_sequence(.data$data, dplyr::slice_tail, ...)
}

#' @exportS3Method dplyr::slice_sample
slice_sample.ggbuilder_plot_data = function(.data, ...) {
  plot_data_sequence(.data$data, dplyr::slice_sample, ...)
}

#' @exportS3Method dplyr::slice_min
slice_min.ggbuilder_plot_data = function(.data, ...) {
  plot_data_sequence(.data$data, dplyr::slice_min, ...)
}

#' @exportS3Method dplyr::slice_max
slice_max.ggbuilder_plot_data = function(.data, ...) {
  plot_data_sequence(.data$data, dplyr::slice_max, ...)
}

#' @exportS3Method dplyr::summarise
summarise.ggbuilder_plot_data = function(.data, ...) {
  plot_data_sequence(.data$data, dplyr::summarise, ...)
}

#' @exportS3Method dplyr::summarize
summarize.ggbuilder_plot_data = function(.data, ...) {
  plot_data_sequence(.data$data, dplyr::summarize, ...)
}


# generics verbs ----------------------------------------------------------

#' @exportS3Method generics::intersect
intersect.ggbuilder_plot_data = function(x, ...) {
  plot_data_sequence(x$data, generics::intersect, ...)
}

#' @exportS3Method generics::union
union.ggbuilder_plot_data = function(x, ...) {
  plot_data_sequence(x$data, generics::union, ...)
}

#' @exportS3Method generics::setdiff
setdiff.ggbuilder_plot_data = function(x, ...) {
  plot_data_sequence(x$data, generics::setdiff, ...)
}


# tidyr verbs -------------------------------------------------------------

#' @exportS3Method tidyr::expand
expand.ggbuilder_plot_data = function(data, ...) {
  plot_data_sequence(data$data, tidyr::expand, ...)
}

#' @exportS3Method tidyr::fill
fill.ggbuilder_plot_data = function(data, ...) {
  plot_data_sequence(data$data, tidyr::fill, ...)
}

#' @exportS3Method tidyr::pivot_longer
pivot_longer.ggbuilder_plot_data = function(data, ...) {
  plot_data_sequence(data$data, tidyr::pivot_longer, ...)
}

#' @exportS3Method tidyr::pivot_wider
pivot_wider.ggbuilder_plot_data = function(data, ...) {
  plot_data_sequence(data$data, tidyr::pivot_wider, ...)
}


# base verbs --------------------------------------------------------------

#' @export
head.ggbuilder_plot_data = function(x, ...) {
  plot_data_sequence(x$data, head, ...)
}

#' @export
tail.ggbuilder_plot_data = function(x, ...) {
  plot_data_sequence(x$data, tail, ...)
}
