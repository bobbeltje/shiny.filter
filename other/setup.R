
install <- function(){
  tar.dir <- 'C:/Users/t975768/OneDrive - Syngenta/Documents/R/win-library/3.5/shiny.filter/htmlwidgets'
  file.copy('inst/htmlwidgets/filter.js', file.path(tar.dir, 'filter.js'), overwrite=TRUE)
  file.copy('inst/htmlwidgets/filter/filter-core.js', file.path(tar.dir, 'filter', 'filter-core.js'), overwrite=TRUE)
  file.copy('inst/htmlwidgets/filter/style.css', file.path(tar.dir, 'filter', 'style.css'), overwrite=TRUE)
}
