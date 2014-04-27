# Getting and Cleaning Data (getdata-002) Project

This repository contains the solution for the getdata-002 course project, with the following files:

- `run_analysis.R` script – the script used to go from the raw data to the tidy dataset specified in the project instructions (more details below).
- `CodeBook.md` – the code book for the resulting dataset, describing the variables, the data and the transformations performed to clean up the data.

## Package dependencies:

- `data.table`

## The `run_analysis` script

---

**IMPORTANT:** the `run_analysis.R` script expects the dataset from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip to be unzipped and fully available in your R session's working directory. I.e.: `{working_directory}/UCI HAR Dataset/`.

---

This script takes the "UCI HAR Dataset" and distils it down to a smaller, tidy dataset with averages for certain features (namely the ones containing mean and standard deviation values), by subject and activity.

You can source it in your working directory using:

```r
source('{path_to_folder}/run_analysis.R')
```

It favours clarity over resource utilisation. E.g. we allocate more objects than probably necessary – at the expense of memory usage – so we can better explain the exact steps as we go along. Given the dataset's predictable size, this was deemed acceptable by the author, and some optimisations were put in place (like only loading the columns necessary) to make the load time bearable on a reasonably specced machine.

Results in a final tidy dataset in memory (`averages`), which contains the average of
each variable (aka "feature"), for each activity, and each subject.


