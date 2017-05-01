require(ggplot2)
require(data.world)
elementaryspending <- query(
  data.world(propsfile ="www/.data.world"),
  dataset="chriscrider/s-17-dv-project-5/", type="sql",
  query = "SELECT * FROM `SchoolSpending.csv/SchoolSpending` as elementaryspending join `PopulationandElementaryEnrollment` as population on(`SchoolSpending`.State = `PopulationandElementaryEnrollment` .State)")
elementaryspending$State_1 <-NULL #removes duplicated states
elementaryspending <-elementaryspending[-1,] #removes the united states section

View(elementaryspending)
df5 = data.frame(elementaryspending)
df5$Spending_Per_Child <- (df5$Total.Spending..in.thousands.*1000/df5$Elementary.secondary.enrollment)

df5$Above_Median_SPC <- df5$Spending_Per_Child > median(df5$Spending_Per_Child)

df5$Elementary_Enrollment_Average <- ifelse (df5$Elementary.secondary.enrollment/df5$State.population..in.thousands.<=mean(df5$Elementary.secondary.enrollment/df5$State.population..in.thousands.),"Below Average Enrollment per State Population","Above Average Enrollment per State Population")

box_plot <- ggplot() +geom_boxplot(aes(x= df5$Above_Median_SPC,y = df5$Spending_Per_Child))
print(box_plot)

