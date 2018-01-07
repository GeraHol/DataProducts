#get data
mydata<-read.table("rat_provs.csv", header = T, sep = ",")

#load packages
library(shiny)
library(dplyr)

#server
shinyServer(function(input, output) 
        observeEvent(c(input$provinces1,input$provinces2), {
                mydataprov1 <- filter(mydata, PROVINCIE == input$provinces1)
                mydataprov2 <- filter(mydata, PROVINCIE == input$provinces2)
                
    output$histPlot <- renderPlot({
          
          hist(mydataprov1$Rating, 
               main = "Density plot of draught ratings in two dutch provinces", 
               xlab = "Ratings",
               ylim=c(0,0.003),
               freq = FALSE,
               col = rgb(0,0,1,0),
               border="white",
               prob = TRUE)
            
            hist(mydataprov2$Rating, 
                 ylim=c(0,0.003),
                 freq = FALSE,
                 col = rgb(1,0,0,0),
                 prob = TRUE,
                 border="white",
                 add = TRUE)
            
            abline(v=median(mydataprov1$Rating, na.rm=T), col=rgb(0,0,1,1), lwd=2)
            abline(v=median(mydataprov2$Rating, na.rm=T), col=rgb(1,0,0,1), lwd=2)
            lines(density(mydataprov1$Rating, na.rm=T), col=rgb(0,0,1,1), lwd=2, lty=2)
            lines(density(mydataprov2$Rating, na.rm=T), col=rgb(1,0,0,1), lwd=2, lty=2)
            
            legend(x = "topright", # location of legend within plot area
                   c(paste("Median",input$provinces1), 
                     paste("Median", input$provinces2),
                     paste("Density", input$provinces1),
                     paste("Density", input$provinces2)
                     ),
                   col = c(rgb(0,0,1,1), 
                           rgb(1,0,0,1),
                           rgb(0,0,1,1),
                           rgb(1,0,0,1)
                           ),
                   lwd = c(2, 2, 2,2),
                   lty=c(1,1,2,2),
                   bty = "n")
                
            
  })
    

})
)