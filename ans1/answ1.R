# I have a custom function that takes as inputs both a dataframe and a specific column of that dataframe. 
# I'd like to use the column name to auto-generate a title, based on a separate labeller argument. 
# I've figured out a way to make it work by using colnames() to isolate the column variable and turn 
# its name into a string, but is there a more efficient way to do this? I am trying to learn how to set up 
# NSE functions properly, but keep running against the limits of my understanding.
# 
# Here is a reproducible example:
# library(dplyr)
# library(ggplot2)
# 
# #sample data
# data(msleep)
# 
# #labels for title generation
# fancylabs <- as_labeller(c('awake' = "Awake", 
#                            'sleep_rem' = "REM"))
# 
# #function to plot two columns and generate a title based on y
# quickplot <- function(df, x, y){
#   
#   #use colnames to convert y to a string - IS THERE A LESS CLUNKY WAY TO DO THIS?
#   yStr <- df %>% select({{y}}) %>% colnames()
#   
#   #plot and use labeller to convert string to fancy label
#   df %>% 
#     ggplot(aes({{x}}, {{y}})) +
#     geom_point() +
#     labs(title=paste0("Total Sleep Time vs. ", fancylabs(yStr), " Time"))
# }
# 
# quickplot(df=msleep, x=sleep_total, y=awake)



# Solution:


library(dplyr)
library(ggplot2)
library(rlang)

# Sample data
data(msleep)

#Function to rename the variables
rename_variable <- function(var_name) {
  var_name <- gsub("_", " ", var_name)  # Replace underscores with spaces
  var_name <- tools::toTitleCase(var_name)  # Change the first letter to a capital letter
  return(var_name)
}

quickplot <- function(df, x, y) {
  # Get the names of x and y columns
  x_name <- deparse(substitute(x))
  y_name <- deparse(substitute(y))
  #Rename the variables
  x_title  <- rename_variable(x_name)
  y_title  <- rename_variable(y_name)
  
  df %>%
    ggplot(aes({{x}}, {{y}})) +
    geom_point() +
    labs(title = paste0(x_title, " vs ", y_title))
}

# Example usage
quickplot(df = msleep, x = sleep_total, y = awake)


# As I understand your function is to make titles for graphs, I can offer you my idea.
# 
# I have created a function that converts the variable name to spelling text, it works only for 
# logically named variables, as in most test databases in R, but it can also be modernized

# You can also add two more parameters x_name and y_name to your function so that 
# the user can enter the name itself, and if they ignore them when entering the 
# function, the rename_variable function will be used





