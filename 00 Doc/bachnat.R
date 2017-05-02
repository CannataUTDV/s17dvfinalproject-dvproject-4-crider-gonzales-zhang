require(data.world)
require(ggplot2)


education <- query(
  data.world(propsfile = "www/.data.world"),
  dataset="chriscrider/s-17-dv-project-6/", type="sql",
  query = "SELECT * FROM `acs-2015-5-e-education-QueryResult.csv/acs-2015-5-e-education-QueryResult`    as Education
  join `acs-2015-5-e-foreignbirth-QueryResult` as Citizenship 
  on( `acs-2015-5-e-education-QueryResult`  .State = `acs-2015-5-e-foreignbirth-QueryResult`.State) "
  
) 

df = data.frame(education)
df <- na.omit(df)
df$kpi_Bach_to_Naturalized <- (df$Bachelors / df$Naturalized)
df$bachelors_abv_average <- (df$Bachelors > mean(df$Bachelors))
df$kpi_bachNat_Ratio_abv_avg <- (df$kpi_Bach_to_Naturalized > mean(df$kpi_Bach_to_Naturalized))



#View(df)


bachplot <- ggplot(df, aes(State, Naturalized, fill=kpi_bachNat_Ratio_abv_avg))+ 
  #scale_y_discrete(labels = scales::comma) + # no scientific notation
  geom_bar(stat='identity') + 
  coord_flip() + 
  geom_errorbar(aes(ymax=Bachelors, ymin=Bachelors))




print(bachplot)