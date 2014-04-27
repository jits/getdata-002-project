library(data.table)

# Prepare all file paths, in a platform agnostic way

FILE_SEP = .Platform$file.sep
DATA_FOLDER = "UCI HAR Dataset"
FEATURES_FILE = paste(DATA_FOLDER, FILE_SEP, "features.txt", sep="")
ACTIVTY_LABELS_FILE = paste(DATA_FOLDER, FILE_SEP, "activity_labels.txt", sep="")
SUBJECT_TEST_FILE = paste(DATA_FOLDER, FILE_SEP, "test", FILE_SEP, "subject_test.txt", sep="")
X_TEST_FILE = paste(DATA_FOLDER, FILE_SEP, "test", FILE_SEP, "X_test.txt", sep="")
Y_TEST_FILE = paste(DATA_FOLDER, FILE_SEP, "test", FILE_SEP, "y_test.txt", sep="")
SUBJECT_TRAIN_FILE = paste(DATA_FOLDER, FILE_SEP, "train", FILE_SEP, "subject_train.txt", sep="")
X_TRAIN_FILE = paste(DATA_FOLDER, FILE_SEP, "train", FILE_SEP, "X_train.txt", sep="")
Y_TRAIN_FILE = paste(DATA_FOLDER, FILE_SEP, "train", FILE_SEP, "y_train.txt", sep="")

# Check that the test folder exists

if (!file.exists(DATA_FOLDER)){
  cat("Data folder -", DATA_FOLDER, "- not found in working directory")
}

# … from this point on we assume the entire dataset is in place, given the
# folder exists, so we won't check for individual files.

# Load up the column names (i.e. the "feature" names) and the activity labels

features <- read.table(FEATURES_FILE, colClasses=c("integer", "character"))
activity_labels <- read.table(ACTIVTY_LABELS_FILE)

# We only want the features that contain "mean()" or "std()"

chosen_feature_indexes <- grep("mean\\(\\)|std\\(\\)", features$V2)

# Load up the `subject` test and train data, and concatenate them into one

subject_test <- read.table(SUBJECT_TEST_FILE)
subject_train <- read.table(SUBJECT_TRAIN_FILE)
subject <- rbind(subject_test, subject_train)

# Load up the `x` test and train data, with the chosen features only,
# and concatenate them into one
#
# Here we set up a `col_classes` vector to describe the classes of each column
# being loaded. By specifying "NULL" on the columns we don't want we can avoid
# loading them up altogether.

col_classes <- rep("NULL", nrow(features))
col_classes[chosen_feature_indexes] <- "numeric"
x_test <- read.table(X_TEST_FILE, colClasses=col_classes)
x_train <- read.table(X_TRAIN_FILE, colClasses=col_classes)
x <- rbind(x_test, x_train)

# Load up the `y` test and train data, and concatenate them into one

y_test <- read.table(Y_TEST_FILE)
y_train <- read.table(Y_TRAIN_FILE)
y <- rbind(y_test, y_train)

# This `y` dataset contains the "activities" performed by the subject.
# We should replace the integers with the more descriptive activity label
# (making it a factor in the process).

y$V1 <- factor(y$V1, labels=activity_labels$V2)

# Now create the fully merged dataset, with appropriate column names added

data <- cbind(subject, cbind(y, x))
col_names <- c("subject", "activity", features$V2[chosen_feature_indexes])
names(data) <- col_names

# Use this to produce a second, independent tidy data set with the average of
# each feature, for each activity, and each subject.
#
# We do this by transforming our data frame into a data table, so we can benefit
# from the special subsetting capabilities of data tables

data_table <- data.table(data)
averages = data_table[, lapply(.SD, mean), by=c("subject", "activity")]

# Finally, sort this data set by the subject and activity

averages = averages[order(averages$subject, averages$activity)]
