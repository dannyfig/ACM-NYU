# Keep our environment clean upon sourcing.
invisible(gc())
rm(list = ls(all = T))

# Let's try a different example with real data! First we'll load
# the basic flights dataset into the `flights` variable.
library(nycflights13)

# Let's do a quick check on our data: dimensions (rows, columns), column names, and a summary.
dim(flights)
str(flights)
summary(flights)

## --
# Great! Here's where I should introduce dplyr and its core verbs:
#   select, filter, arrange, mutate, group by/summarize
## --

# Cool! Now that we kinda know about these verbs, we can try them out.
# First, let's load the tidyverse package.
library(tidyverse)

# Let's try a few examples with each of the verbs.
# 1. Show me just the year and arrival delay columns.
# 2. Show me all columns where the arrival delay time is...negative?!
# 3. Show me (2) but now arrange from least to greatest (e.g. ascending order).
# 4. Show me the arrival delay column but mutated to be the absolute value instead.
# 5. Show me the average arrival delay by month.
# 6. Show me (5), but order the results to show me the worst arrival delay month, first.

# Bleh -- some of these look gross! I could make things better by saving into variables,
# but there are a few (two of them notable!) reasons why we don't want to do that.

# Now we can introduce pipes! Pipes are included in the `tidyverse` and allow you to
# <chain> the output from one function and feed it to the first argument of the next function. 
# (You may have encountered the Unix pipe `|` before!) Let's see how this works.

# Basic example: how would we get the sum of squares from 1 to 100?
values <- 1:100
sum.squared <- sum(values)^2 # !?

# It's easy to mess up when you have messy code! Instead, you can express operation
# 'pipelines' with our pipe operator.
square <- function(x) { x^2 }

values %>%
  square %>%
  sum

####
# Metaphor: it's like defining a recipe! Start with this, do this, do that, then you're done.
####

# Let's go back to our dplyr verbs. Can you re-do those challenges but with pipes?
                  