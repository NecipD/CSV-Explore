# Define server logic
server <- function(input, output, session) {
  data <- reactive({
    req(input$file)
    read.csv(input$file$datapath)
  })
  
  output$fileContents <- renderDT({
    req(data())
    datatable(head(data(), 6))
  })
  
  output$plots <- renderUI({
    req(data())
    num_vars <- sapply(data(), is.numeric)
    cat_vars <- sapply(data(), function(x) is.factor(x) || is.character(x))
    
    plot_output_list <- lapply(names(data())[num_vars], function(var) {
      plotname <- paste0("plot_", var)
      output[[plotname]] <- renderPlot({
        ggplot(data(), aes_string(x = var)) +
          geom_histogram(binwidth = 30, fill = "blue", color = "black") +
          theme_minimal() +
          ggtitle(paste("Histogram of", var))
      })
      plotOutput(plotname, height = "300px")
    })
    
    plot_output_list <- c(plot_output_list, lapply(names(data())[cat_vars], function(var) {
      plotname <- paste0("plot_", var)
      output[[plotname]] <- renderPlot({
        ggplot(data(), aes_string(x = var)) +
          geom_bar(fill = "blue", color = "black") +
          theme_minimal() +
          ggtitle(paste("Bar Chart of", var))
      })
      plotOutput(plotname, height = "300px")
    }))
    
    do.call(tagList, plot_output_list)
  })
}
