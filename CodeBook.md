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

### Transformation of Input Data

The script run_analysis.R captures the processing of the data for this problem.  The data has been downloaded and decompressed in a directory called "data" which is located in the same folder as the script.  The script consists of four primary steps:
1. Ingest of various relevant data files in the original data set.
1. Generation of a consolidated data set (satisfying steps 1-4 described above).
2. Generation of a tidy summary data set (satisfying step 5 described above).
3. Output of a single data file containing the tidy data set.

In our script, we start with the following files:

- activity_labels.txt: 6 x 2 table of activity ids and labels
- features.txt: 561 x 2 table of feature columns and labels
- test/subject_test.txt: 2947 x 1 table of subject ids
- test/y_test.txt: 2947 x 1 table of activity ids
- test/X_test.txt: 2947 x 561 table of features
- train/subject_train.txt: 7352 x 1 table of subject ids
- train/y_train.txt: 7352 x 1 table of activity ids
- train/X_train.txt: 7352 x 561 table of features

as described in Reference 1.

We consolidate the data from these files into a (7352 + 2947) x (1 + 1 + 561) table where the columns are the subject id, the activity id, and the features.  The features are actually composed of estimated quantities related to measurements.  The measurements are:

- tBodyAcc-XYZ
- tGravityAcc-XYZ
- tBodyAccJerk-XYZ
- tBodyGyro-XYZ
- tBodyGyroJerk-XYZ
- tBodyAccMag
- tGravityAccMag
- tBodyAccJerkMag
- tBodyGyroMag
- tBodyGyroJerkMag
- fBodyAcc-XYZ
- fBodyAccJerk-XYZ
- fBodyGyro-XYZ
- fBodyAccMag
- fBodyAccJerkMag
- fBodyGyroMag
- fBodyGyroJerkMag

where '-XYZ' denotes measurements are provided for the X, Y, and Z components of the indicated measure, and where 't' denotes time domain and 'f' denotes frequency domain.  The estimated quantities are:

- mean(): Mean value
- std(): Standard deviation
- mad(): Median absolute deviation 
- max(): Largest value in array
- min(): Smallest value in array
- sma(): Signal magnitude area
- energy(): Energy measure. Sum of the squares divided by the number of values. 
- iqr(): Interquartile range 
- entropy(): Signal entropy
- arCoeff(): Autorregresion coefficients with Burg order equal to 4
- correlation(): correlation coefficient between two signals
- maxInds(): index of the frequency component with largest magnitude
- meanFreq(): Weighted average of the frequency components to obtain a mean frequency
- skewness(): skewness of the frequency domain signal 
- kurtosis(): kurtosis of the frequency domain signal 
- bandsEnergy(): Energy of a frequency interval within the 64 bins of the FFT of each window.
- angle(): Angle between to vectors.

In accordance with the instructions, we only consider estimates for mean() and std(); this reduces the data set to (7352 + 2947) x (1 + 1 + 66).  The 66 consists of 2 x (9 + 3 * 8) since 8 of the 9 measurements have X, Y, and Z components, while 9 have magnitude, and for each the mean and standard deviation are given.

This consolidated data set is considered "messy" because the features are actually a mix of variables and values: the measurements and the estimated quantities, which we ultimately want to compute average values over for each subject and activity.  Our resulting tidy data set variable columns are subject, activity, measurement, axis (X, Y, Z, or Mag), average mean value, and average standard deviation value.  This achieved by a series of manipulations:

1. gather the features into a single column.
2. group by subject, activity, and feature.
3. summarize the groups using the mean to compute an average value of each mean or standard deviation.
4. separate the features to move the axis into a separate column.
5. separate the features to move the statistic type (mean or standard deviation) into a separate column.
6. spread the computed average values to separate mean and standard deviation columns.

### References

1. Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. "A Public Domain Dataset for Human Activity Recognition Using Smartphones." 21th European Symposium on Artificial Neural Networks, Computational Intelligence and Machine Learning, ESANN 2013. Bruges, Belgium 24-26 April 2013.
