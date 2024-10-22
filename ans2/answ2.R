# Column "name" from books is missing in the output m. Is there any way I could keep it? Among other things, 
# I need to watch for unintentional differences (eg typos) between the "by" variables in my datasets.

authors <- data.frame(
  ## I(*) : use character columns of names to get sensible sort order
  surname = I(c("Tukey", "Venables", "Tierney", "Ripley", "McNeil")),
  nationality = c("US", "Australia", "US", "UK", "Australia"),
  deceased = c("yes", rep("no", 4)))
authorN <- within(authors, { name <- surname; rm(surname) })
books <- data.frame(
  name = I(c("Tukey", "Venables", "Tierney",
             "Ripley", "Ripley", "McNeil", "R Core")),
  title = c("Exploratory Data Analysis",
            "Modern Applied Statistics ...",
            "LISP-STAT",
            "Spatial Statistics", "Stochastic Simulation",
            "Interactive Data Analysis",
            "An Introduction to R"),
  other.author = c(NA, "Ripley", NA, NA, NA, NA,
                   "Venables & Smith"))

# m1 <- merge(authorN, books, by.x = "name", by.y = "name", all = TRUE)
# m1


m <- merge(authors, books, by.x = "surname", by.y = "name", all = TRUE)


###Solution


# In the merged dataframe m, the column surname from the authors dataframe is not retained because you are 
# merging by this column, and it gets replaced by the column name from the books dataframe.
# 
# But you can add a name column to the m dataframe and assign a value as I did in the code below


m$name <- NA # Create a new column 'name' and initialize it with NA values
m$name[!is.na(m$surname)] <- m$surname[!is.na(m$surname)] # Copy values from 'surname' to 'name' where 'surname' is not NA
m
 




