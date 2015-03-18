**Coursera Project Code Book**

The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals *tAcc-XYZ* and *tGyro-XYZ*. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals *(tBodyAcc-XYZ and tGravityAcc-XYZ)* using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals *(tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ)*. Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm *(tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag)*. 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing *fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag.* (Note the 'f' to indicate frequency domain signals). 

These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

* tBodyAcc-XYZ
* tGravityAcc-XYZ
* tBodyAccJerk-XYZ
* tBodyGyro-XYZ
* tBodyGyroJerk-XYZ
* tBodyAccMag
* tGravityAccMag
* tBodyAccJerkMag
* tBodyGyroMag
* tBodyGyroJerkMag
* fBodyAcc-XYZ
* fBodyAccJerk-XYZ
* fBodyGyro-XYZ
* fBodyAccMag
* fBodyAccJerkMag
* fBodyGyroMag
* fBodyGyroJerkMag

The set of variables that were estimated from these signals are: 

* mean(): Mean value
* std(): Standard deviation
* mad(): Median absolute deviation 
* max(): Largest value in array
* min(): Smallest value in array
* sma(): Signal magnitude area
* energy(): Energy measure. Sum of the squares divided by the number of values. 
* iqr(): Interquartile range 
* entropy(): Signal entropy
* arCoeff(): Autorregresion coefficients with Burg order equal to 4
* correlation(): correlation coefficient between two signals
* maxInds(): index of the frequency component with largest magnitude
* meanFreq(): Weighted average of the frequency components to obtain a mean frequency
* skewness(): skewness of the frequency domain signal 
* kurtosis(): kurtosis of the frequency domain signal 
* bandsEnergy(): Energy of a frequency interval within the 64 bins of the FFT of each window.
* angle(): Angle between to vectors.

Additional vectors obtained by averaging the signals in a signal window sample. These are used on the angle() variable:

* gravityMean
* tBodyAccMean
* tBodyAccJerkMean
* tBodyGyroMean
* tBodyGyroJerkMean

The complete list of variables of each feature vector in the raw data set is included in the documentation that comes with the data set.  All fields were imported into an R data frame for processing.  Those fields with 'mean' or 'std' in the data set were retained.

The variable names were cleaned up to meet R standards for being syntactically correct.  This includes removing characters such as dashes, underscored and parenthesis.  As the only non-alphanumeric character considered syntactically correct is the period, this was used in the final output to separate the 'mean' prefix from the variable name as some of the variables had mean within their name.  The prefix indicates the records have been aggregated accross the activity and subject to create an average score for each subject engaging in each activity.  

The restult provides discrete averages for each possible combination, thus meeting the requirements of tidy data for

1. Each variable forming a column.  
2. Each observation forming a row.  In this case the requriement is for an aggregated observation that generates a single score for each subject and activity.  
3. Each type of observational unit forms a table.  The the final table exists within the dataSummary data frame and has been extracted as dataSummary.txt.

The variables in the final output file are are: 

* activity                                 
* subject                                 
* mean.timeBodyAccmeanX                    
* mean.timeBodyAccmeanY                   
* mean.timeBodyAccmeanZ                    
* mean.timeGravityAccmeanX                
* mean.timeGravityAccmeanY                 
* mean.timeGravityAccmeanZ                
* mean.timeBodyAccJerkmeanX                
* mean.timeBodyAccJerkmeanY               
* mean.timeBodyAccJerkmeanZ                
* mean.timeBodyGyromeanX                  
* mean.timeBodyGyromeanY                   
* mean.timeBodyGyromeanZ                  
* mean.timeBodyGyroJerkmeanX               
* mean.timeBodyGyroJerkmeanY              
* mean.timeBodyGyroJerkmeanZ               
* mean.timeBodyAccMagmean                 
* mean.timeGravityAccMagmean               
* mean.timeBodyAccJerkMagmean             
* mean.timeBodyGyroMagmean                 
* mean.timeBodyGyroJerkMagmean            
* mean.frequencyBodyAccmeanX               
* mean.frequencyBodyAccmeanY              
* mean.frequencyBodyAccmeanZ               
* mean.frequencyBodyAccmeanFreqX          
* mean.frequencyBodyAccmeanFreqY           
* mean.frequencyBodyAccmeanFreqZ          
* mean.frequencyBodyAccJerkmeanX           
* mean.frequencyBodyAccJerkmeanY          
* mean.frequencyBodyAccJerkmeanZ           
* mean.frequencyBodyAccJerkmeanFreqX      
* mean.frequencyBodyAccJerkmeanFreqY       
* mean.frequencyBodyAccJerkmeanFreqZ      
* mean.frequencyBodyGyromeanX              
* mean.frequencyBodyGyromeanY             
* mean.frequencyBodyGyromeanZ              
* mean.frequencyBodyGyromeanFreqX         
* mean.frequencyBodyGyromeanFreqY          
* mean.frequencyBodyGyromeanFreqZ         
* mean.frequencyBodyAccMagmean             
* mean.frequencyBodyAccMagmeanFreq        
* mean.frequencyBodyBodyAccJerkMagmean     
* mean.frequencyBodyBodyAccJerkMagmeanFreq
* mean.frequencyBodyBodyGyroMagmean        
* mean.frequencyBodyBodyGyroMagmeanFreq   
* mean.frequencyBodyBodyGyroJerkMagmean    
* mean.frequencyBodyBodyGyroJerkMagmeanFreq
* mean.angletBodyAccMeangravity            
* mean.angletBodyAccJerkMeangravityMean   
* mean.angletBodyGyroMeangravityMean       
* mean.angletBodyGyroJerkMeangravityMean  
* mean.angleXgravityMean                   
* mean.angleYgravityMean                  
* mean.angleZgravityMean                   
* mean.timeBodyAccstdX                    
* mean.timeBodyAccstdY                     
* mean.timeBodyAccstdZ                    
* mean.timeGravityAccstdX                  
* mean.timeGravityAccstdY                 
* mean.timeGravityAccstdZ                  
* mean.timeBodyAccJerkstdX                
* mean.timeBodyAccJerkstdY                 
* mean.timeBodyAccJerkstdZ                
* mean.timeBodyGyrostdX                    
* mean.timeBodyGyrostdY                   
* mean.timeBodyGyrostdZ                    
* mean.timeBodyGyroJerkstdX               
* mean.timeBodyGyroJerkstdY                
* mean.timeBodyGyroJerkstdZ               
* mean.timeBodyAccMagstd                   
* mean.timeGravityAccMagstd               
* mean.timeBodyAccJerkMagstd               
* mean.timeBodyGyroMagstd                 
* mean.timeBodyGyroJerkMagstd              
* mean.frequencyBodyAccstdX               
* mean.frequencyBodyAccstdY                
* mean.frequencyBodyAccstdZ               
* mean.frequencyBodyAccJerkstdX            
* mean.frequencyBodyAccJerkstdY           
* mean.frequencyBodyAccJerkstdZ            
* mean.frequencyBodyGyrostdX              
* mean.frequencyBodyGyrostdY               
* mean.frequencyBodyGyrostdZ              
* mean.frequencyBodyAccMagstd              
* mean.frequencyBodyBodyAccJerkMagstd     
* mean.frequencyBodyBodyGyroMagstd         
* mean.frequencyBodyBodyGyroJerkMagstd
