getwd()
list.files()
list.files(path = "Assignments/", recursive="TRUE")


# <-  options minus gives arrow
####Jan 16, 2024####
#finding CSV files
read.csv(list.files(pattern="wingspan_vs_mass.csv",recursive=TRUE))
x <- list.files(pattern = ".csv",recursive = TRUE) #recursive goes through whole directory and subdirectory folder
# saving them to an object "x" puts it into the global enviroment
x[158] #gives us the 158 element of the character vector "x"

dat <-  read.csv(x[158])#this opens file 158



readLines("Data/wide_income_rent.csv")  #read lines of file
read.csv("Data/wide_income_rent.csv")

"Data/wide_income_rent.csv"



#Find any files (recursively) in the Data/ directory that begin with the letter "b" (lowercase)
list.files(path="Data", pattern = "^b",recursive = TRUE)

#^ : carrot means "starts with"


#for-Loop example
bfiles <- list.files(path="Data", pattern = "^b",recursive = TRUE,full.names = TRUE)
readLines(bfiles[1],n=1)

for(i in bfiles){
  print(readLines(i,n=1))
} #don't have to use i


#### Jan. 18, 2024 #### 

#write a for-loop that prints the results of 1+x (each of those numbers)
x <- c(1:5)

for(i in x){
print(i+1)
}

#sequence
seq(1,100, by=7)

#length of a vector use function length()

#character
class(x)
class(class(x))
#things in quotes are not considered numerics

#Vector has a class (numeric, character, integer, data frame). Has one dimension. Everytjing inside must be the same class. Lenght of vector can equal 0
length(c())


##creating a qr code##
library(qrcode)
url <- "https://github.com/Rosiek032123/Data_Course_KENT"
qr <- qrcode::qr_code(url)
plot(qr)


letters[1:10] #gives you the first letrers of the alphabet

letters[c(1,3,5)] #gives you first, third, and fifth letters

a <-  1:10
b <- 2:11
c <- letters[1:10]
a
b
c

cbind(a,b,c)

#dataframe
z <- data.frame(a,b,c) #recognized as data, only works if every item is the same length
class(z)
length(z)
dim(z) #gives dimension of object
