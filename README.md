README for Run_Analysis Code
----------------------------
This code reads the test and training sets and combines them to form one data set and performs
some analysis to extract a tidy data set

The procedure followed for this code is as below:

1) The test data set, subjects and activity are read from the text files

2) The training data set, subjects and activity are read from the text files

3) Each data set has the columns Subject, Activity and Measurements

4) Since the activity column has numeric form of Activity, the first portion of the code reads the
activity_labels text file and then maps each number in the activity column to the corresponding activity

5) Since the columns from the third till the end are measurements and do not have column names, the next portion of the code reads the features.txt file and provides the columns with their respective names

6) Now the complete data set is ready with names to activities and names to columns. Now the code forms a new extracted data set by extracting only the Subject,Activity and the columns with mean and std as part of their column names

7) The extracted data set is a condensed form of the original data set and can be used for analysis. 

8) The goal is to create a tidy data set with average of each variable for each activity for each subject. To do this, we first split the extracted data set based on Subject, this way for each subject we have a data set of all the activities and all the measurements

9) For each subject,the output of step 8 will be split based on Activity. This will result in different datasets for different activities of one subject. The code then find column means on this data set, which will give us the means for the variables in each activity data set. The code then writes the Subject,Activity and the variable means to a data frame.This step is repeated for each subject.

10) Once the averages for all the varibles for all the activities for all the subjects are found and written to the data frame, the data frame is written to a text file.


