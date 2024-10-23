# I have a dataset where cells are occupied by strings of varied length or NAs
# 
# I need to produce one column (say a dataframe consisting of one column) with all strings. 
# Essentially stack all valid string answers filtering NAs out in the process.
# 
# How do I achieve that? Preferably, using tidyverse family of functions.

df.input <- data.frame(col1 = c("green potatoes","read avocados","white pepper","wise master"),
                       col2 = c("white seagull","black tank","creative pigeon","crazy socks"),
                       col3 = c("constant turmoil","ready fan",NA,"interesting collapse"),
                       col4 = c("awesome lettuce","jiggedy cabbage",NA,NA),
                       col5 = c("green potatoes","read avocados",NA,NA),
                       col6 = c("green potatoes",NA,NA,NA),
                       col7 = c(NA,NA,NA,NA)
)

df.output <- data.frame(colOnlyOne = c("green potatoes","read avocados","white pepper","wise master",
                                       "white seagull","black tank","creative pigeon","crazy socks",
                                       "constant turmoil","ready fan","interesting collapse",
                                       "awesome lettuce","jiggedy cabbage",
                                       "and so on for all non-NA string values...")
)


### Solution


# Combine all the columns into one single column by unlisting and removing NA values
df_single_column <- data.frame(colOnlyOne = na.omit(unlist(df.input)))
# Reset row indices
rownames(df_single_column) <- 1:nrow(df_single_column)

df_single_column
