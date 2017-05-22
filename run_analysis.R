library(dplyr)
library(tidyr)

# read in labels
activity_labels <- read.table("data/activity_labels.txt", 
                              row.names = 1, 
                              stringsAsFactors = FALSE)
feature_labels <- read.table("data/features.txt", 
                             row.names = 1, 
                             stringsAsFactors = FALSE)

# read in data files (includes step 4 of instructions)
x_train <- tbl_df(read.table("data/train/X_train.txt", col.names = feature_labels[,'V2']))
y_train <- tbl_df(read.table("data/train/y_train.txt", col.names = c("activity")))
subject_train <- tbl_df(read.table("data/train/subject_train.txt", col.names = c("subject")))
x_test <- tbl_df(read.table("data/test/X_test.txt", col.names = feature_labels[,'V2']))
y_test <- tbl_df(read.table("data/test/y_test.txt", col.names = c("activity")))
subject_test <- tbl_df(read.table("data/test/subject_test.txt", col.names = c("subject")))

# construct consolidated data set (step 1 of instructions)
data_train <- bind_cols(subject_train, y_train, x_train)
data_test <- bind_cols(subject_test, y_test, x_test)
mydata <- bind_rows(data_train, data_test) %>%
  # set activity to label (step 3 of instructions)
  mutate(activity = factor(activity, labels = activity_labels[,'V2'])) %>%
  # select mean and std dev of each measurement (step 2 of instructions)
  select(subject, activity, contains(".mean."), contains(".std."))

# create tidy data set of average mean and standard deviation values for
# each measurement (step 5 of instructions)
mytidysummary <- mydata %>%
  gather(msmt_stat_axis, value, -activity, -subject) %>%  # measurement as single variable
  mutate(msmt_stat_axis = sub("\\.\\.$", "\\.\\.\\.Mag", msmt_stat_axis)) %>%  # cleanup
  mutate(msmt_stat_axis = sub("Mag\\.", "\\.", msmt_stat_axis)) %>%  # cleanup
  group_by(subject, activity, msmt_stat_axis) %>%
  summarize(avg_value = mean(value)) %>%   # compile average measurement values
  separate(msmt_stat_axis, c("msmt_stat", "axis"), sep="\\.\\.\\.") %>%  # axis as variable
  separate(msmt_stat, c("measurement", "stat"), sep="\\.") %>%  # stat as variable
  mutate(measurement = factor(sub("BodyBody", "Body", measurement))) %>%  # cleanup
  spread(stat, avg_value) %>%  # each stat as separate variable
  print

# output tidy data set to file
write.table(mytidysummary, file = "tidy_summary.txt", row.names = FALSE)
