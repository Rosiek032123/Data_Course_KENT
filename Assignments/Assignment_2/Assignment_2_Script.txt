#Assignment 2 (R. Kent)

#Task 4: Find the csv files and save as an object
csv_files <- list.files(path="Data/", pattern = ".csv",recursive = TRUE)


#Task 5: Find how many files matach that description using the length fuction
length(csv_files)


#Task 6:  Open the wingspan_vs_mass.csv file and store the contents as an R object named "df" using the read.csv() function
df <- read.csv(list.files(pattern="wingspan_vs_mass.csv",recursive=TRUE))


#Task 7:  Inspect the first 5 lines of this data set using the head() function
head(df,n=5)


#Task 8:  Find any files (recursively) in the Data/ directory that begin with the letter "b" (lowercase)
list.files(path="Data", pattern = "^b",recursive = TRUE)


#Task 9:  Write a command that displays the first line of each of those "b" files (this is tricky... use a for-loop)
bfiles <- list.files(path="Data", pattern = "^b",recursive = TRUE,full.names = TRUE)

for(i in bfiles){
print(readLines(i,n=1))
}


#Task 10:  Do the same thing for all files that end in ".csv"
csv_files <- list.files(path="Data", pattern = ".csv",recursive = TRUE, full.names = TRUE)
for(i in csv_files){
  print(readLines(i,n=1))
}

