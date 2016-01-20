
library(shiny)
library(ggplot2)

shinyServer(
    function(input, output) {
        output$g1 <- renderPlot({
            str <- NULL
            n <- input$n
            lambda <- 0.2
            mns1 <- NULL
            ic <- 0
            
            if(input$radio == 1){ 
            mns1 <- cumsum(rexp(n*1000, rate = lambda))/(1 : (n*1000))
            str <- "Exponentials"
            ic <- 1/lambda
            }
            else
            {
            mns1 <- cumsum(rnorm(n*1000))/(1 : (n*1000))
            str <- "Standard Normals"
            ic <- 0
            }
            
            g <- ggplot(data.frame(x = 1: (n*1000), y = mns1), aes(x = x, y = y))
            g <- g + geom_hline(yintercept = ic, col = "red") + geom_line(size = 1, col = "blue")
            g <- g +  labs(title = paste("Cumulative Sample Mean for",str," ( Blue: Sample Mean, Red: Theoretical Mean )", sep=" "))
            g <- g + labs(x = "Number of obs", y = "Cumulative mean")
            #g <- g + scale_colour_manual(values = c("Sample mean" = "blue","Theoretical mean" = "red"))
            #g <- g + scale_colour_manual(values = c("blue","red"), labels = c("four", "six"))
           
            g
            
           
        })
        
        
        output$g2 <- renderPlot({
            
            n <- input$n
            lambda <- 0.2
            mns1 <- NULL
            str <- NULL
            r_mean <- 0
            r_sd <- 0
            lim <- NULL
            
            if(input$radio == 1){
            for (i in 1 : 1000) mns1 = c(mns1, mean(rexp(n, rate = lambda)))
            str <- "Exponentials"
            r_mean <- 5
            r_sd <- 5/sqrt(n)
            lim <- c(0, 12)
            }
            else
            {
                
            for (i in 1 : 1000) mns1 = c(mns1, mean(rnorm(n)))   
            str <- "Standard Normals"
            r_mean <- 0
            r_sd <- 1/sqrt(n)
            lim <- c(-2, 2)
            }
            
            x1 <- cbind(mns1, rep(n,1000))
            df <- data.frame(x1)
            colnames(df) <- c("x","size")
            df$"size"<- as.factor(df$"size")
            g <- ggplot(df, aes(x = x, fill = size)) + geom_histogram(alpha = .20, binwidth=.1, colour = "black", aes(y = ..density..)) 
            g <- g + labs(title = paste("Distribution of Sample Mean for",str," (Blue: Sample Mean, Red: Normal for Reference)",sep=" "))
            
            g <- g + stat_function(fun = dnorm, args = list(mean = r_mean, sd = r_sd), color="red") + geom_density(fill=NA, colour="blue")
            #g <- g + xlim(0, 14)
            
           
            g <- g + scale_x_continuous(limits = lim)
            g
            #print(min(df$x))
            #print(max(df$x))
            
            
            
        })
        
    }
)

