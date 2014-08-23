Code book for the run_analysis program
--------------------------------------------------
This is the code book for the run_analysis program and contains details of the variables and transformations used to cleanup the data to obtain the result

1) xtestdata
    - Data Frame data type
    - The content of the X_test file are read into this variable
    - Contains all the measurements/variables for the test data set

2) ytestdata
    - Data Frame data type
    - The content of the Y_test file are read into this variable
    - Contains all the Activities for the test data set

3) subtest
    - Data Frame data type
    - The content of the subject_test file are read into this variable
    - Contains all the Subjects for the test data set

4) xtraindata
    - Data Frame data type
    - The content of the X_train file are read into this variable
    - Contains all the measurements/variables for the training data set

5) ytraindata
    - Data Frame data type
    - The content of the Y_train file are read into this variable
    - Contains all the Activities for the training data set

6) subtrain
    - Data Frame data type
    - The content of the subject_train file are read into this variable
    - Contains all the Subjects for the train data set

7) testdf
    - Data Frame data type
    - The data frames subtest,ytestdata,xtestdata are combined into this
    - This is the master test data set. The first column is the Subject, second is the Activity
      and the remaining columns are the measurements

8) traindf
    - Data Frame data type
    - The data frames subtrain,ytraindata,xtraindata are combined into this
    - This is the master training data set. The first column is the Subject, second is the      
      Activity and the remaining columns are the measurements

9) totaldf
    - Data Frame data type
    - Formed by row bind of testdf and traindf
    - This is the master data set that contains both test and training data. The columns remain as    
      it is

10) actlabel
    - Data Frame data type
    - The content of the activity_labels.txt are read into this variable
    - This contains two columns, the first is the activity number and the second is the activity
      name. This will be used to name all the activities in the activity column in the master data
      set

11) index
    - Logical data type
    - The code matches the content of the Activity column in the master data set against the 
      activity names in actlabel data frame using the %in%. This variable is used to store TRUE
      for all the row matches for a particular activity number and FALSE for all the rows that 
      do not match
    - This index is later used replace the respective activity numbers with activity names by
      replacing the activity numbers in the matching columns by the activity name and this is
      repeated for each activity in actlabel

12) varnames
    - Data Frame data type
    - This variable stores the contents read from features.txt
    - This will contain all the variable names and will be used for naming the columns of the
      master data set. The first two columns of the master data set are named Subject and Activity

13) extractdf
    - Data Frame data type
    - This data frame will contain the data extracted from the master data set that will be used
      for further analysis
    - The Subject and Activity columns are first extracted and become the first two columns of
      the extractdf
    - The columns in the master data set which have column names that contain mean and std are
      extracted out and column binded to the extractdf

14) summarydf
    - Data Frame data type
    - Created to store the final tidy data set that will be created which will give the mean of
      each variable for each activity for each subject
    - Once all the rows for each subject for each activity are added, the column names are given
      by taking the column names of extractdf

15) subjectdf
    - List data type
    - This list stores the result of splitting the extractdf based on Subject
    - Each element in this list corresponds to data for one subject, it will contain data for all
      measurements for all the activities for one subject

16) activitydf
    - List data type
    - This list stores the result of splitting the subjectdf based on Activity
    - For each subject's data, the split is done based on the activity, this will result in a
      list where each element in the list corresponds to data for one activity for one subject
    - This list will be used to find mean for each variable for each activity

17) summarylist
    - List data type
    - The list stores the Subject from the activitydf and Activity from the activitydf and the
      means for each of the variables
    - This list will be row binded to the summarydf as the means are calculated for each subject
      and each activity
