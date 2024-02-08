library(tidyverse)

# data types
typeof(3)        # returns type "double"
typeof(TRUE)     # returns type "logical"
typeof(cars)     # returns "list" (includes data.frames, tibbles, objects, ...)
typeof("huhu")   # returns "character" (= string) 
typeof(mean)     # returns "closure" (= function)
typeof(c)        # returns "builtin" (= deep system internal stuff)
typeof(round)    # returns type "special" (= well, special stuff?)

# learn more about an object by printing it as a string
str(lm)  # This tells that is a function (linear model) and about it

# type-casting
var <- TRUE
as.numeric(var)  # Base R. Returns as numeric.
as.numeric(var)  # Tidyverse. Returns as numeric.

# length of variable
x <- 7
length(x)

# indexing !!! indexing in R starts from 1! NOT 0!
x[1]

x[3] <- 4  # Assign to an unused index. In-between will be NA
x

# c to assign vectors
x <- c(1, 2, 3)
x  # is now a 3-place vector (a list)

# functions to generate sequences
1:10
seq(1, 10, 1)  # same as above
seq(from = 1, to = 10, by = 1)  # same as above, but w/ keywords
seq(from = 1, to = 10, by = 0.5)

# almost all basic operations affect whole vector
x = 1:10
x
x + 1  # 1 added to every element

# Exercise 2.5
nums <- seq(0, 20, 2)  # Generate 0 to 20 with evens
nums <- nums - 1  # Change to odds
nums <- nums[2:11]  # remove negative by selecting 2nd to 11th element
nums  # list of odds

# declaring matrices
x <- c(2, 4, 9, 12)
x
m <- matrix(x)  # Creats a single column matrix from vector x
m

# column-major matrix creation
m <- matrix(1:6, ncol = 3)
m

x = c(1, 0, 1)   # 3-place vector
m %*% x          # dot product (scalar product) with previous matrix 'm'

# dot product is sum of the product of 2 num seqs

# matrix indexing stars with row index 
m[1,]  # shows first row of m

# Exercise 2. 6
x <- seq(0, 1, length.out = 9)
x <- matrix(x, ncol = 3, nrow = 3)
x

sum(x)

# assigning names to vector positions
students <-  c("John", "Jim", "Jazak")
grades <- c(1.3, 2.7, 2.0)
names(grades)  # NULL as not assigned yet

names(grades) <- students
names(grades) 
grades["John"]  # Essentially a dictionary.

grades  # Note: this is not a matrix

c(Jax = 1.5, Jamie = 1.2, Jazzaran = 4.0)  # Alternative method.


# setting names for rows and columns in matrix
m <- matrix(1:6, ncol = 3)  # declare matrix
rownames(m) <- str_c("row", 1:nrow(m), sep = "_")
colnames(m) <- str_c("col", 1:ncol(m), sep = "_")
m

# Booleans
TRUE
FALSE
T
F

# Booleans as index sets
num_vec <- 1:8
bool_vec <- c(T, F, T, T, F, T, T)
num_vec[bool_vec]  # Uses as index set, lack of last sets to TRUE

# Characters (strings)
x <- "huhu"
typeof(x)

# character vector
x <- c("hah", "hmm", "hambo")
x
typeof(x)
length(x)

# stringr package from tidyverse examples (useful package)
str_c("San", "dw", "ich", sep = "_")  # concatenates

chr_vector <- c("huhu", "haha", "hehe", "huhu")
str_which(chr_vector, "hu")  # finds indices for matches (even partial)
str_detect(chr_vector, "ha")  # same with Boolean

str_subset(chr_vector, "hu")  # retrieves the matching elements
str_replace_all(chr_vector, "hu", "bob")  # replaces matched elements
str_replace(chr_vector, "hu" , "hurr")  # replaces first match in element

# separating string by character
times <- "123|733|452"
str_split(times, "\\|", n = 3)  # separates by |, need double  escape for that
# makes a list (vector)

# factors (sets, i think)
chr_vector <- c("huhu", "hello", "huhu", "ciao")
factor(chr_vector)

# the order of levels can be changed manually
factor(chr_vector, levels = c("huhu", "ciao", "hello"))

# creating a true ordered factor
chr_vector <- c("huhu", "hello", "huhu", "ciao")
factor(
  chr_vector,    # the vector to treat as factor
  ordered = T,   # make sure it's treated as ordered factor
  levels = c("huhu", "ciao", "hello")  # specify order of levels by hand
)

# adding an item that is not already on a factor "level" causes trouble
chr_vector <- c("huhu", "hello", "huhu", "ciao")
my_factor <- factor(
  chr_vector,    # the vector to treat as factor
  ordered = T,   # make sure it's treated as ordered factor
  levels = c("huhu", "ciao", "hello")  # specify order of levels
)
my_factor[5] <- "huhu"  # adding a "known category" is okay
my_factor[6] <- "moin"  # adding an "unknown category" does not work
my_factor

# expanding levels with forcats package from tidyverse
chr_vector <- c("huhu", "hello", "huhu", "ciao")
my_factor <- factor(
  chr_vector,    # the vector to treat as factor
  ordered = T,   # make sure it's treated as ordered factor
  levels = c("huhu", "ciao", "hello")  # specify order of levels
)
my_factor[5] <- "huhu"  # adding a "known category" is okay
my_factor <- fct_expand(my_factor, "moin") # add new category
my_factor[6] <- "moin"  # adding new item now works
my_factor

# other useful from forcats package in tidyverse
fct_rev(my_factor)  # reverses
fct_relevel(my_factor, c("hello", "ciao", "huhu"))  #manual new level order

# lists (key-value pairs (dictionary) and arbitrary element type)
my_list <- list(number = 1, name = "bob", vectoral = c("cheese", "ham", "beans"),
                nest_list = list(x = 1, y = 2, z = 3))
my_list

# different ways to call list elements (all return same)
my_list$vectoral
my_list[["vectoral"]]
my_list[[3]]

# data frames. the standard way to store data.
exp_data <- data.frame(
  trial = 1:5,
  condition = factor(c("C1", "C2", "C1", "C3", "C2"), ordered = T),
  response = c(121, 133, 119, 102, 156)
  )
exp_data

# excercise 2.7
a = c("Lou", "Goose", "B")
b = c(31, 31, 34)

age_name <- data.frame(
  friend_name = a,
  friend_age = b
)

age_name

# accessing data frame columns and cells
exp_data[1]  # returns first column
age_name[3,1]  # returns row, column

# excercise 2.8
age_name[1]
age_name["friend_name"]

x <= 32
age_name[age_name[2] <= 32, "friend_name"]

# view function
view(age_name)

# tibbles (tidyverse)
as_tibble(exp_data)

# tibbles are flexible in creation
test_tibble <-  tibble(x = 1:10, y = x^2)
test_dataframe <- data.frame(x = 1:10, y = x^2)  # error

# creating tibble with tribble function
hw_pts <- tribble(
  ~hw_number,  ~Bob,  ~Bill,  ~Jeb,
  "HW1",  33,  24,  17,
  "HW2",  41,  23,  8
)

# Exercise 2.9
bff <- tibble(
  friends = c("Jeb", "Bob", "Bill", "Balthazar", "Imhotep"),
  res = c("Space", "Platform", "Centre", "Hell", "Egypt"),
  age = c(42, 39, 45, 4560, 8000),
  over_50 = (age >= 50),
)

bff["friends"]
bff
