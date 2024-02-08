# 2.4 loops and maps
# for loops

# fix a vector to input
input_vector <- 1:6

#output vector
output_vector <- integer(length(input_vector))

#iterate over length of input
for (i in 1:length(input_vector)) {
  # if even (remainder of division by 2 is 0)
  if (input_vector[i] %% 2 == 0) {
    # multiply by 10
    output_vector[i] <- input_vector[i] * 10
  }
  else {
    output_vector[i] <- input_vector[i]
  }
}

output_vector

#exercise 2.12

a <- c(sample((1:50), 10, replace = T))
b <- c(integer(length(a)))

for (i in 1:length(a)) {
  if (i == 1) {
    b[i] <- (sum(a[i:(i+1)])/3)
  }
  else if (i == length(a)) {
    b[i] <- (sum(a[(i-1):i])/3)
  } 
  else {
    b[i] <- (mean(a[(i-1):(i+1)]))
  }
}

tibble(a, b)

# functional iterators

# map in purrr package
input_vector <- 1:6
map_dbl(
  input_vector,
  function(i) {
    if (input_vector[i] %% 2 == 0) {
      return(input_vector[i] * 10)
    }
    else {
      return (input_vector[i])
    }
  }
)

# shorthand
input_vector <- 1:6
map_dbl(
  input_vector,
  # this is a shorthand. 1st arg is test, 2nd yes, 3rd no
  ~ ifelse(.x %% 2 == 0, .x * 10, .x) 
)

# pmap in purrr package, allows function to apply to more than one input vector
x <- 2:4
y <- 4:6
z <- 7:9

# this takes each element in turn and applies
pmap_dbl(
  list(x, y, z),
  ~ ..1 - ..2 + ..3
)

# Exercise 2.13
input <-  c(12, 6, 18)

map_dbl(
  1: length(input),
  function(i) {
    prod(input[1:i]) / sum(input[1:i])      
  }
)

