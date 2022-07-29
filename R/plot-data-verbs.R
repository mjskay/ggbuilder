# Implementations of lazy dplyr / tidyr verbs for plot_data()


# sequences of lazy operations on plot data -------------------------------

plot_data_sequence = function(x, fun, ...) {
  UseMethod("plot_data_sequence")
}

#' @export
plot_data_sequence.NULL = function(x, fun, ...) {
  plot_data(function(d) fun(d, ...))
}

#' @export
plot_data_sequence.data.frame = function(x, fun, ...) {
  plot_data(fun(x, ...))
}

#' @export
plot_data_sequence.function = function(x, fun, ...) {
  plot_data(function(d) fun(x(d), ...))
}


# dplyr verbs -------------------------------------------------------------

#' @exportS3Method dplyr::arrange ggbuilder_plot_data
arrange.ggbuilder_plot_data = function(.data, ...) {
  plot_data_sequence(.data$data, dplyr::arrange, ...)
}

#' @exportS3Method dplyr::count ggbuilder_plot_data
count.ggbuilder_plot_data = function(x, ...) {
  plot_data_sequence(x$data, dplyr::count, ...)
}

#' @exportS3Method dplyr::distinct ggbuilder_plot_data
distinct.ggbuilder_plot_data = function(.data, ...) {
  plot_data_sequence(.data$data, dplyr::distinct, ...)
}

#' @exportS3Method dplyr::do ggbuilder_plot_data
do.ggbuilder_plot_data = function(.data, ...) {
  plot_data_sequence(.data$data, dplyr::do, ...)
}

#' @exportS3Method dplyr::filter ggbuilder_plot_data
filter.ggbuilder_plot_data = function(.data, ...) {
  plot_data_sequence(.data$data, dplyr::filter, ...)
}

#' @exportS3Method dplyr::group_by ggbuilder_plot_data
group_by.ggbuilder_plot_data = function(.data, ...) {
  plot_data_sequence(.data$data, dplyr::group_by, ...)
}

#' @exportS3Method dplyr::inner_join ggbuilder_plot_data
inner_join.ggbuilder_plot_data = function(x, ...) {
  plot_data_sequence(x$data, dplyr::inner_join, ...)
}

#' @exportS3Method dplyr::left_join ggbuilder_plot_data
left_join.ggbuilder_plot_data = function(x, ...) {
  plot_data_sequence(x$data, dplyr::left_join, ...)
}

#' @exportS3Method dplyr::right_join ggbuilder_plot_data
right_join.ggbuilder_plot_data = function(x, ...) {
  plot_data_sequence(x$data, dplyr::right_join, ...)
}

#' @exportS3Method dplyr::full_join ggbuilder_plot_data
full_join.ggbuilder_plot_data = function(x, ...) {
  plot_data_sequence(x$data, dplyr::full_join, ...)
}

#' @exportS3Method dplyr::mutate ggbuilder_plot_data
mutate.ggbuilder_plot_data = function(.data, ...) {
  plot_data_sequence(.data$data, dplyr::mutate, ...)
}

#' @exportS3Method dplyr::transmute ggbuilder_plot_data
transmute.ggbuilder_plot_data = function(.data, ...) {
  plot_data_sequence(.data$data, dplyr::transmute, ...)
}

#' @exportS3Method dplyr::pull ggbuilder_plot_data
pull.ggbuilder_plot_data = function(.data, ...) {
  plot_data_sequence(.data$data, dplyr::pull, ...)
}

#' @exportS3Method dplyr::select ggbuilder_plot_data
select.ggbuilder_plot_data = function(.data, ...) {
  plot_data_sequence(.data$data, dplyr::select, ...)
}

#' @exportS3Method dplyr::slice ggbuilder_plot_data
slice.ggbuilder_plot_data = function(.data, ...) {
  plot_data_sequence(.data$data, dplyr::slice, ...)
}

#' @exportS3Method dplyr::slice_head ggbuilder_plot_data
slice_head.ggbuilder_plot_data = function(.data, ...) {
  plot_data_sequence(.data$data, dplyr::slice_head, ...)
}

#' @exportS3Method dplyr::slice_tail ggbuilder_plot_data
slice_tail.ggbuilder_plot_data = function(.data, ...) {
  plot_data_sequence(.data$data, dplyr::slice_tail, ...)
}

#' @exportS3Method dplyr::slice_sample ggbuilder_plot_data
slice_sample.ggbuilder_plot_data = function(.data, ...) {
  plot_data_sequence(.data$data, dplyr::slice_sample, ...)
}

#' @exportS3Method dplyr::slice_min ggbuilder_plot_data
slice_min.ggbuilder_plot_data = function(.data, ...) {
  plot_data_sequence(.data$data, dplyr::slice_min, ...)
}

#' @exportS3Method dplyr::slice_max ggbuilder_plot_data
slice_max.ggbuilder_plot_data = function(.data, ...) {
  plot_data_sequence(.data$data, dplyr::slice_max, ...)
}

#' @exportS3Method dplyr::summarise ggbuilder_plot_data
summarise.ggbuilder_plot_data = function(.data, ...) {
  plot_data_sequence(.data$data, dplyr::summarise, ...)
}

#' @exportS3Method dplyr::summarize ggbuilder_plot_data
summarize.ggbuilder_plot_data = function(.data, ...) {
  plot_data_sequence(.data$data, dplyr::summarize, ...)
}


# generics verbs ----------------------------------------------------------

#' @exportS3Method generics::intersect ggbuilder_plot_data
intersect.ggbuilder_plot_data = function(x, ...) {
  plot_data_sequence(x$data, generics::intersect, ...)
}

#' @exportS3Method generics::union ggbuilder_plot_data
union.ggbuilder_plot_data = function(x, ...) {
  plot_data_sequence(x$data, generics::union, ...)
}

#' @exportS3Method generics::setdiff ggbuilder_plot_data
setdiff.ggbuilder_plot_data = function(x, ...) {
  plot_data_sequence(x$data, generics::setdiff, ...)
}


# tidyr verbs -------------------------------------------------------------

#' @exportS3Method tidyr::expand ggbuilder_plot_data
expand.ggbuilder_plot_data = function(data, ...) {
  plot_data_sequence(data$data, tidyr::expand, ...)
}

#' @exportS3Method tidyr::fill ggbuilder_plot_data
fill.ggbuilder_plot_data = function(data, ...) {
  plot_data_sequence(data$data, tidyr::fill, ...)
}

#' @exportS3Method tidyr::pivot_longer ggbuilder_plot_data
pivot_longer.ggbuilder_plot_data = function(data, ...) {
  plot_data_sequence(data$data, tidyr::pivot_longer, ...)
}

#' @exportS3Method tidyr::pivot_wider ggbuilder_plot_data
pivot_wider.ggbuilder_plot_data = function(data, ...) {
  plot_data_sequence(data$data, tidyr::pivot_wider, ...)
}


# base verbs --------------------------------------------------------------

#' @exportS3Method utils::head ggbuilder_plot_data
head.ggbuilder_plot_data = function(x, ...) {
  plot_data_sequence(x$data, utils::head, ...)
}

#' @exportS3Method utils::tail ggbuilder_plot_data
tail.ggbuilder_plot_data = function(x, ...) {
  plot_data_sequence(x$data, utils::tail, ...)
}
