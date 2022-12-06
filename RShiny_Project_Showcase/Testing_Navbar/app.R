backgroundImageCSS <- "/* background-color: #cccccc; */
                       height: 91vh;
                       background-position: center;
                       background-repeat: no-repeat;
                       /* background-size: cover; */
                       background-image: url('%s');
                       opacity: 0.3;
                      transform: scale(1.5);
                      style=z-index:-5;
                       "

library(shiny)
library(shinyWidgets)

# Define UI for application that draws a histogram
ui <- navbarPage("Capstone Project: Gene Fusions and Splice Variant Neoantigens",
                 
                 tabPanel("Scripts",
                          style = sprintf(backgroundImageCSS,  "https://ethz.ch/en/news-and-events/eth-news/news/2020/09/Mechanism-how-coronavirus-hijacks-cell/_jcr_content/news_content/fullwidthimage_778957331/image.imageformat.fullwidth.440830533.jpg"),
                          sidebarLayout(
                            selectInput(
                              inputId='script_choice',
                              label='View Scripts',
                              choices=c('Data Download','Alignment','Fusion Calling','Splice Variant Calling'),
                              selected = 'Data Download',
                              selectize = TRUE,
                              width = NULL,
                              size = NULL),
                            
                            mainPanel(plotOutput("plot"))
                            
                          )),
                 tabPanel("Concepts"),
                 tabPanel("Input Data Exploration"),
                 tabPanel("Output Data Exploration")
)

# Define server logic required to draw a histogram
server <- function(input, output) {
}

# Run the application 
shinyApp(ui = ui, server = server)
