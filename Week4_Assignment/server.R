#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
library(shiny)
library(ggplot2)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
        output$distPlot<-renderPlot({
                #Convert the HairEyeColor data from the data package into a dataframe
                all<-data.frame(HairEyeColor)
                #Define the RGB codes for the hair and eye colors
                blackH<-rgb(0,0,0,max=255)
                brownH<-rgb(139,75,19,max=255)
                redH<-rgb(200,42,42,max=255)
                blondH<-rgb(218,165,32,max=255)
                brownE<-rgb(139,75,19,max=255)
                blueE<-rgb(0,0,155,max=255)
                hazelE<-rgb(205,133,33,max=255)
                greenE<-rgb(0,120,0,max=255)
                #Define female/male for the graph title
                female<-"Females"
                male<-"Males"
                #Remove the variables that are not selected 
                #The "if" logic is based on removing data when checkboxes are not selected
                #This allows the dataframe "all" to keep all of the data that is selected
                if(!input$Female){
                        all<-all[all$Sex!="Female",] #If unselected, removes all female data
                        female<-NULL #If unselected, removes the word "female" from the graph title
                }
                if(!input$Male){
                        all<-all[all$Sex!="Male",] #If unselected, removes all male data
                        male<-NULL #If unselected, removes the word "male" from the graph title
                }
                if(!input$BlackH){
                        all<-all[all$Hair!="Black",] #If unselected, removes all black hair data
                        blackH<-NULL #If unselected, removes this color from graphing scheme
                }
                if(!input$BrownH){
                        all<-all[all$Hair!="Brown",] #If unselected, removes all brown hair data
                        brownH<-NULL #If unselected, removes this color from graphing scheme
                }
                if(!input$RedH){
                        all<-all[all$Hair!="Red",] #If unselected, removes all red hair data
                        redH<-NULL #If unselected, removes this color from graphing scheme
                }
                if(!input$BlondH){
                        all<-all[all$Hair!="Blond",] #If unselected, removes all blond hair data
                        blondH<-NULL #If unselected, removes this color from graphing scheme
                }
                if(!input$BrownE){
                        all<-all[all$Eye!="Brown",] #If unselected, removes all brown eye data
                        brownE<-NULL #If unselected, removes this color from graphing scheme
                }
                if(!input$BlueE){
                        all<-all[all$Eye!="Blue",] #If unselected, removes all blue eye data
                        blueE<-NULL #If unselected, removes this color from graphing scheme
                }
                if(!input$HazelE){
                        all<-all[all$Eye!="Hazel",] #If unselected, removes all hazel eye data
                        hazelE<-NULL #If unselected, removes this color from graphing scheme
                }
                if(!input$GreenE){
                        all<-all[all$Eye!="Green",] #If unselected, removes all green eye data
                        greenE<-NULL #If unselected, removes this color from graphing scheme
                }
                #Calculate the total number of students selected by the radio options
                total_students<-sum(all$Freq)
                
                #Assemble the graph titles
                title<-c(female,male)
                if(length(title)==2){
                        graphtitle<-paste("Hair and Eye Color Breakdown for All",
                                          total_students, 
                                          "Males and Females")
                }else(graphtitle<-paste("Hair and Eye Color Breakdown for",
                                        total_students,
                                        title,
                                        "Students"))
                
                #Assemble the color vectors for graphing
                #The hair/eye colors that have NULL values won't graph
                haircolor<-c(blackH,brownH,redH,blondH)
                eyecolor<-c(brownE,blueE,hazelE,greenE)
                
                #Graph based on the radio button selected (i.e. based on which
                #variable is selected to be on the x-axis)
                if(input$radio=="Hair Color"){
                        ggplot(all,aes(x=Hair,y=Freq,col=Eye,fill=Eye))+
                                geom_bar(stat="identity")+
                                scale_fill_manual(values=eyecolor,"Eye Color")+
                                scale_color_manual(values=eyecolor,"Eye Color")+
                                xlab("Hair Color")+
                                ylab("Number of Students")+
                                ggtitle(graphtitle)+
                                theme(plot.title=element_text(hjust=0.5,face="bold"))
                }else{
                        ggplot(all,aes(x=Eye,y=Freq,col=Hair,fill=Hair))+
                                geom_bar(stat="identity")+
                                scale_fill_manual(values=haircolor,"Hair Color")+
                                scale_color_manual(values=haircolor, "Hair Color")+
                                xlab("Eye Color")+
                                ylab("Number of Students")+
                                ggtitle(graphtitle)+
                                theme(plot.title=element_text(hjust=0.5,face="bold"))
                }
       
                })
        

                
        })
