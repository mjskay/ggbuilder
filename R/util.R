# set missing values from x to provided default values
defaults = function(x, defaults) {
  c(x, defaults[setdiff(names(defaults), names(x))])
}

stop0 = function(...) {
  stop(..., call. = FALSE)
}
