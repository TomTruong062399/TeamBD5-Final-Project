library(shiny)

ui <- shinyUI(navbarPage(
  "Insert Project Name",
    tabPanel(
      "Key Terms",
      titlePanel("Key Term Search"),
      sidebarLayout(
        sidebarPanel(
          textInput("term",
                    label = "Enter a Term",
                    value = ""),
          sliderInput("quantity",
                      label = "Specify how many tweets",
                      min = 1,
                      max = 10,
                      value = 5,
                      ticks = TRUE,
                      animate = FALSE)
        ),
        mainPanel(
          tableOutput("key_tweets")
        )
      )
    ),
    tabPanel(
      "Temp",
      titlePanel("Temporary"),
      sidebarLayout(
        sidebarPanel("Left Panel"),
        mainPanel("Right Panel")
      )
    )
  )
)
