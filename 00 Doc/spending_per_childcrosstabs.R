require(ggplot2)
require(data.world)
elementaryspending <- query(
  data.world(propsfile ="www/.data.world"),
  dataset="chriscrider/s-17-dv-project-5/", type="sql",
  query = "SELECT * FROM `SchoolSpending.csv/SchoolSpending` as elementaryspending join `PopulationandElementaryEnrollment` as population on(`SchoolSpending`.State = `PopulationandElementaryEnrollment` .State)")
elementaryspending$State_1 <-NULL #removes duplicated states
elementaryspending <-elementaryspending[-1,] #removes the united states section

df = data.frame(elementaryspending)
df$Spending_Per_Child <- (df$Total.Spending..in.thousands.*1000/df$Elementary.secondary.enrollment)

df$Above_Median_SPC <- df$Spending_Per_Child > median(df$Spending_Per_Child)

df$Elementary_Enrollment_Average <- ifelse (df$Elementary.secondary.enrollment/df$State.population..in.thousands.<=mean(df$Elementary.secondary.enrollment/df$State.population..in.thousands.),"Below Average Enrollment per State Population","Above Average Enrollment per State Population")
View(df)

cross_tab <- ggplot(df) + geom_text(aes(x = Above_Median_SPC, y=State, label=Spending_Per_Child),size=3)+xlab("Above Median Spending Per Child")+geom_tile(aes(x=Above_Median_SPC, y=State,fill=Elementary_Enrollment_Average), alpha=0.50)

print(cross_tab)

