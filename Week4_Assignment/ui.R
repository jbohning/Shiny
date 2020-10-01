library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Understanding Hair and Eye Color for a Group of Students"),
  # Checkboxes for what data to graph
  sidebarLayout(
    sidebarPanel(
       #Need a title here too
            h5("Chose the variables that you would like to graph and then click 'Submit'"),
            checkboxInput("Female",label="Females",value=TRUE),
            checkboxInput("Male",label="Males",value=TRUE),
            checkboxInput("BlackH",label="Black Hair",value=TRUE),
            checkboxInput("BrownH",label="Brown Hair",value=TRUE),
            checkboxInput("RedH",label="Red Hair",value=TRUE),
            checkboxInput("BlondH",label="Blond Hair",value=TRUE),
            checkboxInput("BrownE",label="Brown Eyes",value=TRUE),
            checkboxInput("BlueE",label="Blue Eyes",value=TRUE),
            checkboxInput("HazelE",label="Hazel Eyes",value=TRUE),
            checkboxInput("GreenE",label="Green Eyes",value=TRUE),
            h5("Which variable do you want on the x-axis?"),
            radioButtons("radio",label=NULL,
                         choices=c("Hair Color","Eye Color")),
            submitButton("Submit")
  
    ),
    # Create tabs to show a plot and the documentation
    #The plot will graph all of the selected variables and calculate how 
    # many students are include
    mainPanel(
            tabsetPanel(tabPanel("Plot", plotOutput("distPlot",height="550px")), 
                        tabPanel("Documentation", 
                                 h5("DOCUMENTATION"),
                                 p("This app takes inputs of sex, hair color, and eye color
                                   and calculates the number of students in the survey with
                                   those features and then graphs them."),
                                 p("The user can use the check boxes to decide which variables
                                   are going to be used for the calcualtion and graphing.
                                   The user can also decide whether to put hair color or eye
                                   color on the x-axis."),
                                 p("Click the 'Submit' button to update the graph and the 
                                   student count."),
                                 h5("WHY ISN'T THE GRAPH SHOWING ANYTHING?"),
                                 p("If the graph is empty, ensure that you've selected enough
                                   options to graph:"),
                                 p("*Ensure that you've at least selected 'male' or 'female' (because everyone interviewed identified 
                                   as one or the other)."),
                                 p("*Ensure that you've at least selected one of the 
                                   four hair colors (because all students interviewed had 
                                   hair)"),
                                 p("*Ensure that you've at least selected one of the four eye
                                   colors (because the students interviewed only had these
                                   eye colors)"),
                                 p("STILL HAVING ISSUES after trying all of the above? Email
                                   fakeemail@email.com to report the issue."))))
            
    )
  )
)
