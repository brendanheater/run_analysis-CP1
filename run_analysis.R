run_analysis <- function(){

##  List of calls for 2 big dataframes, and column names    
#    train_x    <- read.table("./UCI HAR Dataset/train/X_train.txt")
#    test_x     <- read.table("./UCI HAR Dataset/test/X_test.txt")
    
    feat_name  <- read.table("./UCI HAR Dataset/features.txt")
    
## establish column names and extract important columns

    features <- rbind(train_x, test_x)
    colnames(features) <- feat_name[,2]
    features <- features[,grepl("mean()", names(features), fixed = TRUE) | 
                          grepl("std()", names(features), fixed = TRUE)]  
    keep_n   <- names(features)  #store column names for later
    
#    rm(list = c("train_x", "test_x", "feat_name"))

##  calls for smaller subject and activity datasets    
    train_subj <- read.table("./UCI HAR Dataset/train/subject_train.txt")
    train_y    <- read.table("./UCI HAR Dataset/train/y_train.txt")
    test_subj  <- read.table("./UCI HAR Dataset/test/subject_test.txt")
    test_y     <- read.table("./UCI HAR Dataset/test/y_test.txt")
        
    act_name <- read.table("./UCI HAR Dataset/activity_labels.txt")

##  combine Subject and Activity data, change Activity number to a word 

    subjects   <- rbind(train_subj, test_subj)
    activities <- rbind(train_y, test_y)
    activities$Activity <- act_name$V2[match(activities$V1, act_name$V1)]
    
    full       <- cbind(subjects, activities$Activity, features)

    colnames(full) <- c("Subject", "Activity", keep_n)

#    rm(list = setdiff(ls(), "full"))

    tidyDS  <- aggregate(. ~ Subject+Activity, data = full, FUN = function(full) 
                         c(mn = mean(full, n = length(full))))
    tidyDS  <- tidyDS[order(tidyDS$Subject, tidyDS$Activity),]

    write.table(tidyDS, "./Tidy Data.txt", row.names=FALSE)
}