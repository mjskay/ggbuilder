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

#' @importFrom dplyr arrange
#' @export
arrange.ggbuilder_plot_data = function(.data, ...) {
  plot_data_sequence(.data$data, dplyr::arrange, ...)
}

#' @importFrom dplyr count
#' @export
count.ggbuilder_plot_data = function(x, ...) {
  plot_data_sequence(x$data, dplyr::count, ...)
}

#' @importFrom dplyr distinct
#' @export
distinct.ggbuilder_plot_data = function(.data, ...) {
  plot_data_sequence(.data$data, dplyr::distinct, ...)
}

#' @importFrom dplyr do
#' @export
do.ggbuilder_plot_data = function(.data, ...) {
  plot_data_sequence(.data$data, dplyr::do, ...)
}

#' @importFrom dplyr filter
#' @export
filter.ggbuilder_plot_data = function(.data, ...) {
  plot_data_sequence(.data$data, dplyr::filter, ...)
}

#' @importFrom dplyr group_by
#' @export
group_by.ggbuilder_plot_data = function(.data, ...) {
  plot_data_sequence(.data$data, dplyr::group_by, ...)
}

#' @importFrom dplyr inner_join
#' @export
inner_join.ggbuilder_plot_data = function(x, ...) {
  plot_data_sequence(x$data, dplyr::inner_join, ...)
}

#' @importFrom dplyr left_join
#' @export
left_join.ggbuilder_plot_data = function(x, ...) {
  plot_data_sequence(x$data, dplyr::left_join, ...)
}

#' @importFrom dplyr right_join
#' @export
right_join.ggbuilder_plot_data = function(x, ...) {
  plot_data_sequence(x$data, dplyr::right_join, ...)
}

#' @importFrom dplyr full_join
#' @export
full_join.ggbuilder_plot_data = function(x, ...) {
  plot_data_sequence(x$data, dplyr::full_join, ...)
}

#' @importFrom dplyr mutate
#' @export
mutate.ggbuilder_plot_data = function(.data, ...) {
  plot_data_sequence(.data$data, dplyr::mutate, ...)
}

#' @importFrom dplyr transmute
#' @export
transmute.ggbuilder_plot_data = function(.data, ...) {
  plot_data_sequence(.data$data, dplyr::transmute, ...)
}

#' @importFrom dplyr pull
#' @export
pull.ggbuilder_plot_data = function(.data, ...) {
  plot_data_sequence(.data$data, dplyr::pull, ...)
}

#' @importFrom dplyr select
#' @export
select.ggbuilder_plot_data = function(.data, ...) {
  plot_data_sequence(.data$data, dplyr::select, ...)
}

#' @importFrom dplyr slice
#' @export
slice.ggbuilder_plot_data = function(.data, ...) {
  plot_data_sequence(.data$data, dplyr::slice, ...)
}

#' @importFrom dplyr slice_head
#' @export
slice_head.ggbuilder_plot_data = function(.data, ...) {
  plot_data_sequence(.data$data, dplyr::slice_head, ...)
}

#' @importFrom dplyr slice_tail
#' @export
slice_tail.ggbuilder_plot_data = function(.data, ...) {
  plot_data_sequence(.data$data, dplyr::slice_tail, ...)
}

#' @importFrom dplyr slice_sample
#' @export
slice_sample.ggbuilder_plot_data = function(.data, ...) {
  plot_data_sequence(.data$data, dplyr::slice_sample, ...)
}

#' @importFrom dplyr slice_min
#' @export
slice_min.ggbuilder_plot_data = function(.data, ...) {
  plot_data_sequence(.data$data, dplyr::slice_min, ...)
}

#' @importFrom dplyr slice_max
#' @export
slice_max.ggbuilder_plot_data = function(.data, ...) {
  plot_data_sequence(.data$data, dplyr::slice_max, ...)
}

#' @importFrom dplyr summarise
#' @export
summarise.ggbuilder_plot_data = function(.data, ...) {
  plot_data_sequence(.data$data, dplyr::summarise, ...)
}

#' @importFrom dplyr summarize
#' @export
summarize.ggbuilder_plot_data = function(.data, ...) {
  plot_data_sequence(.data$data, dplyr::summarize, ...)
}


# generics verbs ----------------------------------------------------------

#' @importFrom generics intersect
#' @export
intersect.ggbuilder_plot_data = function(x, ...) {
  plot_data_sequence(x$data, generics::intersect, ...)
}

#' @importFrom generics union
#' @export
union.ggbuilder_plot_data = function(x, ...) {
  plot_data_sequence(x$data, generics::union, ...)
}

#' @importFrom generics setdiff
#' @export
setdiff.ggbuilder_plot_data = function(x, ...) {
  plot_data_sequence(x$data, generics::setdiff, ...)
}


# tidyr verbs -------------------------------------------------------------

#' @importFrom tidyr expand
#' @export
expand.ggbuilder_plot_data = function(data, ...) {
  plot_data_sequence(data$data, tidyr::expand, ...)
}

#' @importFrom tidyr fill
#' @export
fill.ggbuilder_plot_data = function(data, ...) {
  plot_data_sequence(data$data, tidyr::fill, ...)
}

#' @importFrom tidyr pivot_longer
#' @export
pivot_longer.ggbuilder_plot_data = function(data, ...) {
  plot_data_sequence(data$data, tidyr::pivot_longer, ...)
}

#' @importFrom tidyr pivot_wider
#' @export
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
