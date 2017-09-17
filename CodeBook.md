# Code Book
## 

run_analysis.R reads the data from the UCI HAR dataset and creates a tidy data frame containing the average values for each mean and std measurement for each subject during each activity. This data is written to averages.txt.

I chose to select only the -mean() and -std() variables, excluding the additional vectors described at the end of features_info.txt.

Variable names are cleaned by removing the '-' and '()' characters and converting all characters to lowercase. Thus, `tBodyAcc-mean()-X` in the original data becomes `tbodyaccmeanx` in the final tidy data.