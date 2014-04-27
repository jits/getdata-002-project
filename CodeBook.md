# Code Book for the `averages` dataset

This code book describes the resulting `averages` dataset from the `run_analysis` script.

# Source of data

Raw data was taken from the "UCI HAR Dataset" – Human Activity Recognition Using Smartphones.

Details: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

# Variables

- `subject` – _numeric_ – the ID of the test subject the entry is for
- `activity` – _categorical_ – the type of activity being performed by the test subject – from:
  - `WALKING`
  - `WALKING_UPSTAIRS`
  - `WALKING_DOWNSTAIRS`
  - `SITTING`
  - `STANDING`
  - `LAYING`
- The remaining variables are average measures from the accelerometer and gyroscope sensors on the smartphone. The averages are by subject and by activity, i.e. each subject will have one row per activity where the values in the sensor columns contain averages across multiple recordings of data (from the raw data source). For more information on these fields, please see the `features_info.txt` file in the dataset's folder (there's no use repeating all that info here!)

# Transformations and summary choices

The raw data set contained multiple recordings of values per feature per subject and per activity. Whilst this may be useful to draw up distributions and calculate various summary statistics over, the aim of the `averages` dataset is to only summarise by averages of each of the features (per subject and activity).

Furthermore, only the `mean()` and `std()` variables were chosen.
