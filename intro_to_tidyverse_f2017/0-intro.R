# Keep our environment clean upon sourcing.
invisible(gc())
rm(list = ls(all = T))

#######################
#### Pipe operator ####
#######################

# Let's say we have a vector of values -- let's say they're a model's prediction errors.
errors <- rnorm(n = 100, mean = 10, sd = 1)

# Now, what if we wanted to square each one? Well, since R is a functional language,
# it'll <<vectorize>> operations and functions that work on single values and 
# apply them along the vector.
errors^2

# Cool! But this is pretty easy. What if we wanted to compute the RMSE metric?
# To get the RMSE (root mean squared-error) metric, you work from inside-out. Hence,
# we take the errors, square them, take the mean, then take the square root of that mean.
# How would we do that? Can we use what we did just before?

# Okay, we know SE from before:
errors^2

# To get the mean:
mean(errors^2)

# To get the square root:
(mean(errors^2))^.5

####
# Bleh! That looks gross...but we'll live, right? (Spoiler: nope)
####

# To be fair, we could have made things a bit nicer:
square <- function(x) { x^2 }
root <- function(x) { x^(1/2) }

root(mean(square(errors)))