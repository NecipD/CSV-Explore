# Load required libraries
library(shiny)
library(shinydashboard)
library(ggplot2)
library(DT)

# Define UI
ui <- dashboardPage(
  dashboardHeader(title = "CSV File Explorer"),
  dashboardSidebar(
    sidebarMenu(
      menuItem("Upload and Explore", tabName = "explore", icon = icon("upload"))
    )
  ),
  dashboardBody(
    tabItems(
      tabItem(
        tabName = "explore",
        fluidRow(
          box(
            title = "Upload CSV File",
            width = 4,
            fileInput("file", "Choose CSV File", accept = ".csv")
          ),
          box(
            title = "Data Preview",
            width = 12,
            DTOutput("fileContents")
          ),
          box(
            title = "Variable Distributions",
            width = 12,
            uiOutput("plots")
          )
        )
      )
    )
  )
)

