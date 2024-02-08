# 2.5 Piping
library(tidyverse)

# define input
input_vector <- c(0.4, 0.5, 0.6)

# center-embedded style
# first round, then take mean
mean(round(input_vector)) 


# one workaround is storying intermediate values ----
# vector for input
input_vector <- c(0.4, 0.5, 0.6)

# rounded input
rounded_input <- round(input_vector)

# mean of rounded input
mean(rounded_input)

# piping allows passing results of function to next ----
# magrittr package gives infix operator

# below are equivalent pseudo-code examples, where f is a function
x %>% f
f(x)

# equivalent to above is:

input_vector %>% round() %>% mean()

# pseudo-code of specifying what arg slot
# equivalent
y %>% f(x, .)
f(x,y)

# exercise 2.14 ----

# weird formatted data
weird_RTs <- c("RT = 323", "RT = 345", "RT = 421", "RT = 50")

# my solution
weird_RTs %>% str_split_i("=", 2) %>% as.numeric() %>% log() %>% mean() %>% 
  round(2)

# their solution
weird_RTs %>%
  stringr::str_sub(start = 6) %>%  # uses stringr package for extract char
  as.numeric() %>%
  log %>%
  mean %>% 
  signif(digits = 2)  # not 100% on what the diff here

# other magrittr operators ----
library(magrittr)

# tree pipe (passes input ti LHS to RHS unmodded)
input_vector <- c(0.4, 0.5, 0.6)
input_vector %>%
  # get the mean
  mean %T>%
  # output intermediate result
  print %>%
  # do more computations
  sum(3)

# exposition pipe (passes names to RHS even if not normally allowed)
# this won't work
tibble(
  x = 1:3
) %>%    # normal pipe 
  sum(x) # error: object `x` not found

# this will
tibble(
  x = 1:3
) %$%    # exposition pipe makes 'x' available
  sum(x) # works!

# assignment pipe assigns final value back to LHS
x <- c(0.4, 0.5, 0.6)
# x is changed in place
x %<>%
  sum(3) %>%
  mean
print(x)

# Base R has introduced native pipe operator. Requires brackets (magrittr doesn't)
1:10 |> mean    # error!
1:10 |> mean()  # 5.5

# zeallot any multiple assignment operator
library(zeallot)

c(x, y) %<-% c(10, "garbo")

# useful for functions returning several outputs in a list or vector
# define test data
input_vector <- c(0.4, 0.5, 0.6)

# define a function that outputs multiple values in a list (key-value)
ex_function <- function(input) {
  return(list(sum = sum(input), mean = mean(input)))
}

# call the function with input and sep list to vars
c(x, y) %<-% ex_function(input_vector)
x
y
