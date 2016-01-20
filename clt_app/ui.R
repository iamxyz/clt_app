shinyUI(pageWithSidebar(
    headerPanel("Experiments for Law of Large Numbers and Central Limit Theorem"),
    sidebarPanel(
        h4("Introduction to the experiments:"),
        h5("The experiments are used to investigate simulation distributions in R and prove the correctness of Law of Large Numbers  ( LLN ) and Central Limit Theorem ( CLT )."),
        HTML("<hr>"),
        h4("Three steps to make experiments:"),
        h5("Step 1: Select the simulation type. "),
        h5("Step 2: Set the sample size."),
        h5("Step 3: Watch the experiment results."),
        HTML("<hr>"),
        radioButtons("radio", label = h4("Simulation Type"),
                    choices = list("Exponential ( lambda = 0.2 )" = 1, "Standard Normal ( mu = 0, sd = 1 )" = 2),selected = 1),
        sliderInput("n", label = h4("Sample Size"),value = 10, min = 10, max = 50, step = 10),
        HTML("<hr>"),
        h5("Note: One simulation with selected sample size will be repeated 1000 times."),
        h6("Author: Yulong Deng, Date: 2016-1-20")
    ),
    mainPanel(
        
        plotOutput('g1'),
        h5("The experiment result shows that the sample mean will converge to theoretical mean. It proves that LLN is correct."),
        HTML("<hr>"),
        plotOutput('g2'),
        h5("The experiment result shows that the variance of the average of samples will become less with the increaing sample size, and it will converge to theoretical variance / sample size, and the distribution of average of samples is approximately normal, as a bell curve. It proves that CLT is correct.")
    )
))



