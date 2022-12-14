% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/layer-spec.R
\name{layer_spec}
\alias{layer_spec}
\alias{new_layer_spec}
\title{Pipable ggplot2 layer specifications}
\usage{
new_layer_spec()
}
\value{
A ggbuilder \link{layer_spec} representing a layer to be constructed by \code{\link[=new_layer]{new_layer()}}.
}
\description{
A specification for a \link[ggplot2:layer]{ggplot2::layer} built from a \link{layer_spec} and intended for
piping. Typically constructed using \code{\link[=geom_]{geom_()}} or \code{\link[=stat_]{stat_()}}, not this function.
}
\examples{

# See geom_() or stat_() for examples; this function
# should not usually be used directly.

}
