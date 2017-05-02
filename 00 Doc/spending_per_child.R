require(ggplot2)
require(data.world)
elementaryspending <- query(
  data.world(propsfile ="www/.data.world"),
  dataset="chriscrider/s-17-dv-project-5/", type="sql",
  query = "SELECT * FROM `SchoolSpending.csv/SchoolSpending` as elementaryspending join `PopulationandElementaryEnrollment` as population on(`SchoolSpending`.State = `PopulationandElementaryEnrollment` .State)")

elementaryspending$State_1 <-NULL
elementaryspending$`Other (in thousands)` <-NULL
elementaryspending$`State population (in thousands)` <-NULL
elementaryspending$`From Federal Sources (in thousands)` <-NULL
elementaryspending$`From State Sources (in thousands)` <-NULL
elementaryspending$`From Local Sources (in thousands)` <-NULL
elementaryspending$`Capital Outlay (in thousands)` <-NULL
elementaryspending$`Current Spending (in thousands)` <-NULL
df = data.frame(elementaryspending)
df$SR_Ratio <- (df$Total.Spending..in.thousands./df$Total.Revenue..in.thousands.)
df$Spending_Per_Child <- (df$Total.Spending..in.thousands.*1000/df$Elementary.secondary.enrollment)

bar_plot <- ggplot(df) +geom_bar(aes(x=State,y = Spending_Per_Child,color=Spending_Per_Child),stat = "identity") + ylab("Spending Per Child") + theme(axis.text.x=element_text(angle=45,hjust=1,vjust=1))
print(bar_plot) 