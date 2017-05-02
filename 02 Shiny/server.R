require(dplyr)
require(ggplot2)
require(scales)
require(data.world)



source("www/R_ETL.R")

df1 <- data.frame(education)

df1$pps_abv_avg <- (df1$`X2014.PPCS` > mean(df1$`X2014.PPCS`))
df1$bach_abv_avg <- (df1$Bachelors > 500000)
df1$kpi_bach_ratio <- (df1$Bachelors / df1$`Current.Spending`)
highbardf <- dplyr::filter(df1, pps_abv_avg == TRUE)
lowbardf <- dplyr::filter(df1, pps_abv_avg == FALSE)


 
elementaryspending$State_1 <-NULL #removes duplicated states
elementaryspending <-elementaryspending[-1,] #removes the united states section

df = data.frame(elementaryspending)
df$Spending_Per_Child <- (df$`Total.Spending..in.thousands`*1000/df$`Elementary.secondary.enrollment`)

df$Above_Median_SPC <- df$Spending_Per_Child > median(df$Spending_Per_Child)

df$Elementary_Enrollment_Average <- ifelse (df$Elementary.secondary.enrollment/df$State.population..in.thousands.<=mean(df$Elementary.secondary.enrollment/df$State.population..in.thousands.),"Below Average Enrollment per State Population","Above Average Enrollment per State Population")

df5 = data.frame(elementaryspending)
df5$Spending_Per_Child <- (df5$Total.Spending..in.thousands.*1000/df5$Elementary.secondary.enrollment)

df5$Above_Median_SPC <- df5$Spending_Per_Child > median(df5$Spending_Per_Child)

df5$Elementary_Enrollment_Average <- ifelse (df5$Elementary.secondary.enrollment/df5$State.population..in.thousands.<=mean(df5$Elementary.secondary.enrollment/df5$State.population..in.thousands.),"Below Average Enrollment per State Population","Above Average Enrollment per State Population")

server <- function(input, output) {

  output$plot1 <- renderPlot({
    ggplot(highbardf, aes(x=State, y=X2014.PPCS, fill=bach_abv_avg))+ 

      geom_bar(stat='identity') +
      ylab('Per Child Spending') +
      coord_flip() +
      ggtitle('Bachcelors Performance - High Spending States') +
      geom_text(aes(label=Bachelors))

    
  })
  output$plot2 <- renderPlot({
    ggplot(lowbardf, aes(x=State, y=X2014.PPCS, fill=bach_abv_avg)) + 
      geom_bar(stat='identity') +
      ylab('Per Child Spending') +
      coord_flip() +
      ggtitle('Bachelors Performance - Low Spending States') + 
      geom_text(aes(label=Bachelors))
  })
  
  output$plot3 <- renderPlot({
       ggplot(df1) + geom_histogram(aes(x = `X2014.PPCS`, fill = I('dodgerblue4'), col=I('red'))) + 
      xlab('Per Child Spending') + 
      ylab('Bin of States') +
      ggtitle('Per Pupil Spending Range')
  })
  
  output$plot4 <- renderPlot({
    ggplot(df1, aes(x=State,  y=kpi_bach_ratio, fill = kpi_bach_ratio)) + 
      geom_bar(stat='identity') + 
      theme(axis.text.x=element_text(angle=90, size=10, vjust=0.5))+
      ylab('Bachelor Attainment to Spending Ratio') + 
      ggtitle('KPI Bachelor Ratio Performance by State')
  })
  output$plot5 <-renderPlot({ggplot(df) + geom_text(aes(x = Above_Median_SPC, y=State, label=Spending_Per_Child),size=3)+xlab("Above Median Spending Per Child")+geom_tile(aes(x=Above_Median_SPC, y=State,fill=Elementary_Enrollment_Average), alpha=0.50)})

  output$plot6 <-renderPlot({ ggplot(df5) +geom_boxplot(aes(x= df5$Above_Median_SPC,y = df5$Spending_Per_Child))})
  
  output$plot7<-renderPlot({ggplot(incomestuff, aes(x=Income, y=`2014 PPCS`)) + geom_point(shape=1) + geom_smooth(method=lm)+ scale_x_continuous(name="Income", label=dollar)+scale_y_continuous(name="2014 PPCS", label=dollar)})

}