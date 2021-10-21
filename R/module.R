
filterUI <- function(id, cols){

  ns <- NS(id)

  tagList(
    lapply(cols, function(x) filterOutput(ns(x)))
  )
}

filterServer <- function(input, output, session, data, cols){

  ns <- session$ns

  e <- environment()
  filters <- list()
  last <- NULL

  display <- reactiveValues()
  refresh_display <- reactiveVal(0)
  filtered <- reactiveVal(data)

  for (i in cols) display[[i]] <- mixedsort(setdiff(unique(data[[i]]), NA))

  observeEvent(refresh_display(), priority=1, ignoreInit=TRUE, {
    if (!is.data.frame(data)) return(NULL)

    filtered(subset_data(data, filters))

    if (isTRUE(last %in% names(filters)) && !is.null(filters[[last]])) cols <- setdiff(cols, last)
    for (i in cols) {
      v <- mixedsort(setdiff(unique(filtered()[[i]]), NA))
      if (!identical(display[[i]], v)) display[[i]] <- v
    }
  })

  lapply(cols, function(x){

    output[[x]] <- renderFilter({
      if (!hasName(display, x)) return(NULL)
      values <- display[[x]]
      selected <- which(values %in% filters[[x]])
      make_filter(values, selected)
    })

    observeEvent(input[[paste0(x, '_selected')]], ignoreNULL=F, ignoreInit=T, {

      i <- input[[paste0(x, '_selected')]]
      e$last <- x
      v <- c('All', display[[x]])

      if (is.null(i) || i==1){
        e$filters[[x]] <- NULL
      } else {
        e$filters[[x]] <- v[i]
      }
      refresh_display(runif(1))
    })
  })

  return(filtered)
}

subset_data <- function(df, subsets){

  for (col in names(subsets)){
    if (is.null(subsets[[col]]) || is.null(df[[col]])) next
    df <- df[df[[col]] %in% subsets[[col]], ]
  }

  return(df)
}

make_filter <- function(values, selected){
  selected <- if (!length(selected)) NULL else selected + 1
  filter(
    values=c('All', values),
    options=list(
      selected=selected
    )
  )
}
