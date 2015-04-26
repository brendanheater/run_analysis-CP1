# run_analysis-CP1
Tidy Data Course Project, Week 3 Coursera Course.

The purpose of this exercise was to develop a piece of code which combines a number of files (listed below).  This code combines these files into a single data frame that allows the user to see the general results from the various readings.  The source data is a series of tests done on 30 subjects, using an accelerometer to test there movement throughout a series of normal activities.

The code works as follows:

- Assuming the folder containing the data set (UCI HAR Dataset) is saved in the working directory, the code reads the two largest components (X_test.txt and X_train.txt) and the name of the readings from the accelerometer (features.txt).  The readings are explained in more detail in the "Code Book" file in this repository.  
(lines 4-7)
- With these three pieces, the code binds the training and test data, labels the data, and searches the names for "mean()" OR "std()".  The code returns a narrower dataset, with only 66 columns, rather than 560+ 
(lines 11-15)
- To minimize the memory commitment, the code removes the raw data from memory, retaining a list of the remaining column names, and the columns themselves
(line 17)

- The code next opens the list of subjects and activities, both for the train group and the test group.
(lines 20-25)
- We bind the groups together, using rbind, and then match the Activity numbers with the corresponding qualitative value (Standing, Walking, etc).
(lines 29-31)
- using the cbind function, we create the large dataset.  Following that, we rename the columns using the "keep_n" object from before, and remove all files except for the full dataset.
(lines 33-35)

- to make the final product, we use the aggregate function to take the mean of the subset of rows in each column which share common Subject and Activity values.  We also order that new dataframe(tidyDS) by Subject and Activity.
(lines 39-41)

- The final step is writing the table to a text file for submission.
(line 43)
