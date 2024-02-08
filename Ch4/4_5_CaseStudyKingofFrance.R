# going through a case study of pre-processing and cleaning data
library(tidyverse)

# import raw data from aida package
raw_KoF_data <- aida::data_KoF_raw

# provisional data examination
glimpse(raw_KoF_data)

# look at comments
raw_KoF_data %>% pull(comments) %>% unique

# look at languages
raw_KoF_data %>% pull(languages) %>% unique

# pruning data not to be used in analysis
raw_KoF_data <- raw_KoF_data %>%
  select(-languages, -comments, -age, -RT, -education, -gender)

# focus on one participant and ignore practice to get a sense of info
raw_KoF_data %>%
  #ignore practice trials
  # focus on one participant
  filter(trial_type != "practice", submission_id == 192) %>%
  select(trial_type, item_version, question) %>%
  arrange(desc(trial_type), item_version) %>%
  print(n = Inf)

# changing columns so that condition contains trial type and q version
proc_KoF_data <- raw_KoF_data %>%
  # drop redundant information in column trial_name
  select(-trial_name) %>%
  #discard practice trials
  filter(trial_type != "practice") %>%
  mutate(
    # add a condition variable
    condition = case_when(
      trial_type == "special" ~ "background check",
      trial_type == "main" ~ str_c("Condition ", item_version),
      TRUE ~ "filler"
    ) %>%
      # make new condition var. a factor
      factor(
        ordered = T,
        levels = c(
          str_c("Condition ", c(0, 1, 6, 9, 10)),
          "background check", "filler"
        )
      )
  )


# cleaning by participant
# look at error rate for fillers by subject
# mark subj as outlier if 
# proportion answered correctly is less than 0.5

subject_error_rate <- proc_KoF_data %>%
  filter(trial_type == "filler") %>%
  group_by(submission_id) %>%
  summarise(
    proportion_correct = mean(correct_answer == response),
    outlier_subject = proportion_correct < 0.5
  ) %>%
  arrange(proportion_correct)

# add info on error to data and then exclude outliers
d_cleaned <- 
  full_join(proc_KoF_data, subject_error_rate, by = "submission_id") %>%
  filter(outlier_subject == FALSE)

# excluding critical trials where background test was answered incorrectly
d_cleaned <- d_cleaned %>%
  # select only background q trials
  filter(trial_type == "special") %>%
  # is bg answer correct? add col with answer
  mutate(
    bg_correct = correct_answer == response
  ) %>%
  # select relevant columns
  select(submission_id, vignette, bg_correct) %>%
  # right join lines to original data set
  right_join(d_cleaned, by = c("submission_id", "vignette")) %>%
  
  filter(trial_type == "main" & bg_correct == TRUE)

clean_test <- aida::data_KoF_cleaned

clean_test
d_cleaned


