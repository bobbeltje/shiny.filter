
library(shiny)
library(shiny.filter)

ui <- fluidPage(
  filterOutput('f1')
)

server <- function(input, output, session) {
  output$f1 <- renderFilter({
    filter(
      1:10,
      options=list(
        selected=c(1,4,5)
      )
    )
  })
  observe({
    print(input$f1_selected)
  })
}

shinyApp(ui, server)

# module ####

library(gtools)
library(shiny)
library(shiny.filter)
library(DT)

data <- rutils::gen_data(dt=FALSE)

ui <- fluidPage(
  fluidRow(
    column(
      width=2,
      filterUI('filters', c('c1', 'c2', 'c3'))
    ),
    column(
      width=10,
      DT::dataTableOutput('tbl')
    )
  )
)

server <- function(input, output, session) {
  d <- callModule(filterServer, 'filters', data, c('c1', 'c2', 'c3'))
  output$tbl <- DT::renderDataTable({
    datatable(d())
  })
}

shinyApp(ui, server)

# scribbling ####

# ** observe doesn't work ####
ui <- fluidPage(
  sliderInput('in1', 'in1', 1, 4, 1),
  uiOutput('out1')
)

server <- function(input, output, session) {
  output$out1 <- renderUI({
    if (input$in1 == 1) return(div('foo'))
    if (input$in1 == 2) return(div(filter(1:10)))
  })
  observe({
    print(input$out1_selected)
  })
}
