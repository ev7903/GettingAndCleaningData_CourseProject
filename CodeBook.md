# Code Book - TidyData.txt   
* [column 1]__Activities__ _(char)_: The descriptive names of the six activities in the experiment    
column contents:   
  + "WALKING"    
  + "WALKING_UPSTAIRS"   
  + "WALKING_DOWNSTAIRS"   
  + "SITTING"   
  + "STANDING"   
  + "LAYING"   
    
* [column 2]__Subjects__ _(int)_: The integer numbers stand for the 30 voluteers in the experiment   
column contents:   
  + 1-30    
     
* [column 3]__Group__ _(char)_: The partition data set that the voluteers belongs to    
column contents:   
  + "test"    
  + "train"    
      
* [column 4-69]__The Average Mean and Standard Deviation of the measurements__ _(double)_: The average of each variable for each activity and each subject    
  The meaning of the varible name in code:   
  - prefix "t": time domain signals   
  - prefix "f": frequency domain signals   
  - "BodyAcc": Body acceleration signals    
  - "GravityAcc": Gravity acceleration signals    
  - "BodyGyro": Body gyroscope signals    
  - "Jerk": The signal derived in time      
  - "Mag": The signals calculated using the Euclidean norm     
  - "-X": measure in X axis of the phone     
  - "-Y": measure in Y axis of the phone     
  - "-Z": measure in Z axis of the phone     
  - "-mean()": Mean value    
  - "-std()": Standard deviation