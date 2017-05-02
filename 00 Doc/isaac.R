require(dplyr)
require(ggplot2)
require(data.world)
require(scales)

df1 <- query(
  data.world(propsfile = "www/.data.world"),
  dataset="chriscrider/s-17-edv-project-3", type="sql",
  query = "SELECT *
FROM Pupil_Per_Spending join USA_All_States_Income on (Pupil_Per_Spending.`Abbreviation:`=USA_All_States_Income.State)"

) 

names(df1)

df <- df1
names(df)
str(df) # Uncomment this line and  run just the lines to here to get column types to use for getting the list of measures.

measures <- c("2014 PPCS", "Income", "State", "Abbreviation:", "Race")

dimensions <- setdiff(names(df), measures)
dimensions

# Get rid of special characters in each column.
# Google ASCII Table to understand the following:
for(n in names(df)) {
  df[n] <- data.frame(lapply(df[n], gsub, pattern="[^ -~]",replacement= ""))
}

str(df)
# The following is an example of dealing with special cases like making state abbreviations be all upper case.
# df["State"] <- data.frame(lapply(df["State"], toupper))

# The following is an example of dealing with special cases like making state abbreviations be all upper case.
# df["State"] <- data.frame(lapply(df["State"], toupper))

na2emptyString <- function (x) {
  x[is.na(x)] <- ""
  return(x)
}
if( length(dimensions) > 0) {
  for(d in dimensions) {
    # Change NA to the empty string.
    df[d] <- data.frame(lapply(df[d], na2emptyString))
    # Get rid of " and ' in dimensions.
    df[d] <- data.frame(lapply(df[d], gsub, pattern="[\"']",replacement= ""))
    # Change & to and in dimensions.
    df[d] <- data.frame(lapply(df[d], gsub, pattern="&",replacement= " and "))
    # Change : to ; in dimensions.
    df[d] <- data.frame(lapply(df[d], gsub, pattern=":",replacement= ";"))
  }
}

na2zero <- function (x) {
  x[is.na(x)] <- 0
  return(x)
}
# Get rid of all characters in measures except for numbers, the - sign, and period.dimensions, and change NA to 0.
if( length(dimensions) > 1) {
  for(m in dimensions) {
    print(m)
    df[m] <- data.frame(lapply(df[m], gsub, pattern="[^--.0-9]",replacement= ""))
    df[m] <- data.frame(lapply(df[m], na2zero))
    df[m] <- lapply(df[m], function(x) as.numeric(as.character(x)))
    # This is needed to turn measures back to numeric because gsub turns them into strings.
  }
}

str(df)

p <- ggplot(df1, aes(x= State, y=`Income`))+geom_boxplot()+scale_y_continuous(name="Income", label=dollar)+ geom_point(aes(x=State, y=`2014 PPCS`, color="red"))

print(p)
