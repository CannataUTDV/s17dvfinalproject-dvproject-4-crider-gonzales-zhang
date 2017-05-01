require(dplyr)
require(ggplot2)
require(data.world)


education <- query(
  data.world(propsfile = "www/.data.world"),
  dataset="chriscrider/s-17-edv-project-3", type="sql",
  query = "SELECT * FROM ElementarySpending join `acs-2015-5-e-education-QueryResult` 
  on (ElementarySpending.State = `acs-2015-5-e-education-QueryResult`.AreaName)"
) 

df1 <- data.frame(education)
df1 <- na.omit(df1)

df1$pps_abv_avg <- (df1$X2014.PPCS > mean(df1$X2014.PPCS))
df1$bach_abv_avg <- (df1$Bachelors > 500000)
df1$kpi_bach_ratio <- (df1$Bachelors / df1$Current.Spending)
highbardf <- dplyr::filter(df1, pps_abv_avg == TRUE)
lowbardf <- dplyr::filter(df1, pps_abv_avg == FALSE)


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
       ggplot(df1) + geom_histogram(aes(x = X2014.PPCS, fill = I('dodgerblue4'), col=I('red'))) + 
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

  


}