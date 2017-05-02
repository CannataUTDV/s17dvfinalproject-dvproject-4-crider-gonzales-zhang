require(dplyr)
require(data.world)
#-----------------------FILE ONE------------------------------------------

df1 <- query(
  data.world(propsfile = "www/.data.world"),
  dataset="chriscrider/s-17-edv-project-3", type="sql",
  query = "SELECT * FROM ElementarySpending join `acs-2015-5-e-education-QueryResult` 
  on (ElementarySpending.State = `acs-2015-5-e-education-QueryResult`.AreaName)"
) 


df <- df1
names(df)
str(df) # Uncomment this line and  run just the lines to here to get column types to use for getting the list of measures.


dimensions <- c("State", "AreaName")

measures <-  setdiff(names(df), dimensions)


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
if( length(measures) > 1) {
  for(m in measures) {
    print(m)
    df[m] <- data.frame(lapply(df[m], gsub, pattern="[^--.0-9]",replacement= ""))
    df[m] <- data.frame(lapply(df[m], na2zero))
    df[m] <- lapply(df[m], function(x) as.numeric(as.character(x)))
 # This is needed to turn measures back to numeric because gsub turns them into strings.
  }
}

education <- df

str(education)


#-----------------------FILE TWO----------------------------------------


df2 <- query(
  data.world(propsfile ="www/.data.world"),
  dataset="chriscrider/s-17-dv-project-5/", type="sql",
  query = "SELECT * FROM `SchoolSpending.csv/SchoolSpending` as elementaryspending join `PopulationandElementaryEnrollment` as population on(`SchoolSpending`.State = `PopulationandElementaryEnrollment` .State)")


df <- df2
names(df)
str(df) # Uncomment this line and  run just the lines to here to get column types to use for getting the list of measures.


dimensions <- c("State", "State_1")

measures <-  setdiff(names(df), dimensions)


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
if( length(measures) > 1) {
  for(m in measures) {
    print(m)
    df[m] <- data.frame(lapply(df[m], gsub, pattern="[^--.0-9]",replacement= ""))
    df[m] <- data.frame(lapply(df[m], na2zero))
    df[m] <- lapply(df[m], function(x) as.numeric(as.character(x)))
    # This is needed to turn measures back to numeric because gsub turns them into strings.
  }
}

elementaryspending <- df

str(elementaryspending)
#-----------------------FILE THREE----------------------------------------


dataframee <- query(
  data.world(propsfile = "www/.data.world"),
  dataset="chriscrider/s-17-edv-project-3", type="sql",
  query = "SELECT *
  FROM Pupil_Per_Spending join USA_All_States_Income on (Pupil_Per_Spending.`Abbreviation:`=USA_All_States_Income.State)"
  
) 


df <- dataframee
names(df)
str(df) # Uncomment this line and  run just the lines to here to get column types to use for getting the list of measures.

dimensions <- c("Geographic area", "State", "Abbreviation:", "Race")

measures <- setdiff(names(df), dimensions)



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
if( length(measures) > 1) {
  for(m in measures) {
    print(m)
    df[m] <- data.frame(lapply(df[m], gsub, pattern="[^--.0-9]",replacement= ""))
    df[m] <- data.frame(lapply(df[m], na2zero))
    df[m] <- lapply(df[m], function(x) as.numeric(as.character(x)))
    # This is needed to turn measures back to numeric because gsub turns them into strings.
  }
}

incomestuff <- df



