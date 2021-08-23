
list_dependencies <- function(){
  list(
    htmltools::htmlDependency(
      name='filter-core',
      version='0.1.0',
      package='shiny.filter',
      src=file.path('htmlwidgets', 'filter'),
      script='filter-core.js'
    ),
    htmltools::htmlDependency(
      name='style',
      version='0.1.0',
      package='shiny.filter',
      src=file.path('htmlwidgets', 'filter'),
      stylesheet='style.css'
    )
  )
}
