File Name: ReadMe.txt

Author: David Lee

Data: 17 March 2013

Purpose: The purpose of this ReadMe file is to describe the run_analysis.R script to which this
		 file is associated and the logic used to process the data.  The data set processed is a data set downloaded from the UCI machine learning repository at 
		 http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones.
		 
Data Set Information:
	The information about the data set as provided by the data source is as follows:
	The experiments have been carried out with a group of 30 volunteers within an age bracket 
	of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, 
	WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) 
	on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear 
	acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have 
	been video-recorded to label the data manually. The obtained dataset has been randomly 
	partitioned into two sets, where 70% of the volunteers was selected for generating the 
	training data and 30% the test data. 

	The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise 
	filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 
	readings/window). The sensor acceleration signal, which has gravitational and body motion 
	components, was separated using a Butterworth low-pass filter into body acceleration and 
	gravity. The gravitational force is assumed to have only low frequency components, therefore 
	a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was 
	obtained by calculating variables from the time and frequency domain.

Processing steps.  An outline of the processing steps is incorporated into the script as comments.
As a first step a working directly was established.  The script checks to see if the directory 
exists and if not, the directory is created.  This script used a directory that was mapped to a 
server rather than to the PC on which the script was run.  Anyone wishing to run the script for
themselves should modify the working directory location so as to be appropriate to their 
particular computing environment.
	
After the working directory has been established a check is done to insure the necessary 
packages have been installed on the processing computer.  Should any not be present then they 
are automatically installed.  It is assumed common base packages are installed.  Checks are 
done for these additional packages: downloader, plyr, dplyr and utils.  If the script fails 
because it is looking for another package that is not present the name of the package can be 
added to the package list in the script and it will be automatically installed.  A library() 
line would also need to be added to load the package in preparation for running the script.

After the check for and loading of the needed R packages the file to be processed is downloaded 
to the working directory.  The file is Dataset.zip.  As a zip file it is subsequently unzipped 
which results in several files being extracted from the zip archive, including two directories 
containing additional files.

The files of specific interest for the analysis are the x_train.txt and x_test.txt files.  
These files contain training data and test data sets.  Per the goal of the project, the two 
files are recombined to create a single data set.  The y_train.txt and y_test.txt files contain 
the code for the activity of the recorded data, such as sitting or standing.  The 
subject_train.txt and subject_text.txt files contain the an integer key representing one of 
each of the 30 subjects who participated in the study.  The activity and subject data is added 
to the respective tables, along with a column indicating whether the record came from the train 
or test data set.

After the train and test data sets have been assembled into data frames they are combined into 
a single table: accelData.  A row exists for each subject and activity and is also differentiated 
by other values such as time and frequency measures.  For details about the table variables see 
the associated codebook.

After the combined data table is created the variable names for each column are read from the 
features.txt file into a labels vector.  Additional variable names are added for the activity, 
subject and dataset columns.  The vector is then used to assign the names to the columns in the 
data set.

Subsequent processing errors resulted from some columns having duplicate names.  A visual 
examination showed that those with duplicate names were not of interest for the subsequent 
processing steps so they were removed from the data set by inserting the data into a new data 
frame, AData using a deduplication step. 

Only records that contained mean or standard deviation data were of subsequent interest.  These 
were selected from the AData data set and inserted into a new data frame called meanStdData, along 
with the activity, subject and dataset fields.

The activity_labels.txt file provided descriptive names of the various activities.  These values 
and their keys where loaded into a data frame called activity.  Column names were added to the 
activity data frame, including "activityKey" which provided a common name for the keys between 
the activity data frame and the meanStdData data frame which enabled the joining of the two data 
frames, thus adding the activity descriptions to the meanStdData data frame.

Once added the column variable names were cleaned up to syntactically valid.  The make.names() 
function was used to remove all non-alphanumeric characters and replace them with periods, which 
meets the R standards for being syntactically correct.  However, this result any a large number 
of periods being inserted into various column names.  Sometimes 4 or 5 in a row.  Subsequent steps 
removed the periods and also replaced prefixed t with time and prefixed f with frequency to make 
the variable names much more readable and understandable.  Other abbreviated terms in the variable 
names were deemed sufficiently clear as to not require further elaboration as striking the desired 
balance between clarity and not making the names too cumbersome are both goals of tidy data.

The final step in the process is to find the average of the columns by activity and subject.  
Grouping was applied to the meanStdData data frame and extracted into the "groupedMeanStdData" data 
frame.  The summarize() function was then applied to the groupedMeanStdData data frame to achieve 
the final result.  Although writing out the mean() function for each variable in the data frame 
initially seemed as if it would be a tedious task, listing the column names with the colnames 
function and copying the results into notepad++ enabled the structure of the script in about 10 
minutes using the replace function.  The script was then copied back into the R script where it 
worked well, resulting in the final data set needed for the project requirements.

However, the column names once again contained parenthesis, which do not meet R standards for being 
syntactically correct.  A final step replace the left parenthesis with a period so the prefixed 
"mean", which indicated the summary mean for the group, would stand apart from the "mean" which may 
be in the column name.  The right parenthesis at the end of the column name was removed, resulting 
in names that meet R's syntactically correct standards.


