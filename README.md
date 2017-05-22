# Course Project: Getting and Cleaning Data
## Jeff Beck
## 21 May 2017

### Project Instructions (from https://www.coursera.org/learn/data-cleaning/peer/FIZtT/getting-and-cleaning-data-course-project)

The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set.The goal is to prepare tidy data that can be used for later analysis. You will be graded by your peers on a series of yes/no questions related to the project. You will be required to submit:

1. a tidy data set as described below
2. a link to a Github repository with your script for performing the analysis
3. a code book that describes the variables, the data, and any transformations or work that you performed to clean up the data called CodeBook.md.
4. a README.md in the repo with your scripts that explains how all of the scripts work and how they are connected.

One of the most exciting areas in all of data science right now is wearable computing - see for example this article . Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Here are the data for the project:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

You should create one R script called run_analysis.R that does the following:

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names.
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

### Review criteria
- The submitted data set is tidy.
- The Github repo contains the required scripts.
- GitHub contains a code book that modifies and updates the available codebooks with the data to indicate all the variables and summaries calculated, along with units, and any other relevant information.
- The README that explains the analysis files is clear and understandable.
- The work submitted for this project is the work of the student who submitted it.

### Approach
The script run_analysis.R captures the processing of the data for this problem.  The data has been downloaded and decompressed in a directory called "data" which is located in the same folder as the script.
The script consists of four primary steps:
1. Ingest of various relevant data files in the original data set.
1. Generation of a consolidated data set (satisfying steps 1-4 described above).
2. Generation of a tidy summary data set (satisfying step 5 described above).
3. Output of a single data file containing the tidy data set.

### Satisfaction of Tidy Criteria
In our script, we start with the following files:

- activity_labels.txt: 6 x 2 table of activity ids and labels
- features.txt: 561 x 2 table of feature columns and labels
- test/subject_test.txt: 2947 x 1 table of subject ids
- test/y_test.txt: 2947 x 1 table of activity ids
- test/X_test.txt: 2947 x 561 table of features
- train/subject_train.txt: 7352 x 1 table of subject ids
- train/y_train.txt: 7352 x 1 table of activity ids
- train/X_train.txt: 7352 x 561 table of features

We consolidate these into a (7352 + 2947) x (1 + 1 + 561) table where the columns are the subject id, the activity id, and the features.  The features are actually composed of estimated quantities related to measurements.  The measurements are:

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

