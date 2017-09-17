# Code Book
## 

run_analysis.R reads the data from the UCI HAR dataset and creates a tidy data frame containing the average values for each mean and std measurement for each subject during each activity. This data is written to averages.txt.

The test and train data are read in. Test and train are combined to form one dataset.

The feature vector is assigned to the column names of the data.

The subject and activity labels are added as columns using `cbind()`.

Only the `-mean()` and `-std()` variables are selected (this excludes the additional vectors described at the end of `features_info.txt`).

Variable names are cleaned by removing the '-' and '()' characters and converting all characters to lowercase. Thus, `tBodyAcc-mean()-X` in the original data becomes `tbodyaccmeanx`.

The average of each variable for each subject and each activity is calculated using `aggregate`.
