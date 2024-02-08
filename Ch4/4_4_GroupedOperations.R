# performing multiple operations

# to get a summary stat for different subsets
# extracting mean grade for Rozz
mean_grade_Rozz <- exam_results_tidy %>% 
  filter(student == "Rozz") %>% 
  pull(grade) %>% 
  mean
mean_grade_Rozz

# to avoid repeating, we writen a func and use map_dbl to add mean
get_mean_for_student <- function(student_name) {
  exam_results_tidy %>% 
    filter(student == student_name) %>% pull(grade) %>% mean
}

# applies operation to each element
map_dbl(
  exam_results_tidy %>% pull(student) %>% unique,
  get_mean_for_student
)
# this is clumsy however

# tidyverse offers a solution: grouping
# use group_by followed by mutate or summarise

# this groups by student
# then summarise provides mean for grade
# and result is displayed with specified group-by columns
exam_results_tidy %>% 
  group_by(student) %>% 
  summarise(
    student_mean = mean(grade)
  )

# mutate instead adds mean result to original table
exam_results_tidy %>% 
  group_by(student) %>% 
  mutate(
    student_mean = mean(grade)
  )
