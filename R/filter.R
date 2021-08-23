#' <Add Title>
#'
#' <Add Description>
#'
#' @import htmlwidgets
#'
#' @export
filter <- function(values, width = NULL, height = NULL, elementId = NULL) {

  # forward options using x
  x = list(
    values = values
  )

  # create widget
  htmlwidgets::createWidget(
    name = 'filter',
    x,
    width = width,
    height = height,
    package = 'shiny.filter',
    elementId = elementId,
    dependencies = list_dependencies()
  )
}

#' Shiny bindings for filter
#'
#' Output and render functions for using filter within Shiny
#' applications and interactive Rmd documents.
#'
#' @param outputId output variable to read from
#' @param width,height Must be a valid CSS unit (like \code{'100\%'},
#'   \code{'400px'}, \code{'auto'}) or a number, which will be coerced to a
#'   string and have \code{'px'} appended.
#' @param expr An expression that generates a filter
#' @param env The environment in which to evaluate \code{expr}.
#' @param quoted Is \code{expr} a quoted expression (with \code{quote()})? This
#'   is useful if you want to save an expression in a variable.
#'
#' @name filter-shiny
#'
#' @export
filterOutput <- function(outputId, width = '100%', height = '400px'){
  htmlwidgets::shinyWidgetOutput(outputId, 'filter', width, height, package = 'shiny.filter')
}

#' @rdname filter-shiny
#' @export
renderFilter <- function(expr, env = parent.frame(), quoted = FALSE) {
  if (!quoted) { expr <- substitute(expr) } # force quoted
  htmlwidgets::shinyRenderWidget(expr, filterOutput, env, quoted = TRUE)
}
