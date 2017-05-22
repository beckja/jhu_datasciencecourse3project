# Codebook for Course Project: Getting and Cleaning Data
## Jeff Beck
## 21 May 2017

### Description
This captures the data contained in the "tidy_summary.txt" data file.  Details of the data from which this data set is derived are contained in the README.md file and its references.

### Variables

1. "subject" <int>: numerical ID associated with subject (participant); range = [1-30]

2. "activity" <string>: label for activity subject is engaged in at time of measurement; values in {"WALKING", "WALKING_UPSTAIRS", "WALKING_DOWNSTAIRS", "SITTING", "STANDING", "LAYING"}

3. "measurement" <string>: label for quantity being measured; format is "aBbbbCcccDddd" where a is "t" or "f" for time or frequency domain, Bbbb is in {"Body", "Gravity"}, Cccc is in {"Acc", "Gyro"}, Dddd is in {"", "Jerk"}

4. "axis" <string>: body-axis component or total magnitude; value is in {"X", "Y", "Z", "Mag"}

5. "mean" <double>: average value of mean values for given subject, activity, measurement, and axis, with measurements normalized on [-1,1]

6. "std" <double>: average value of stand deviation for given subject, activity, measurement, and axis, with measurements normalized on [-1,1]

