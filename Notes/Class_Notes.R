# New R projects (top corner)
# This tells R where you want to start
####Codes to Use####
getwd()
setwd()
dir()
list.files()
#'alt -' gives the <- 
# list.files(path = "Assignments/")
#Finding file types; like if I want to find all ".csv" files.
list.files(pattern = ".csv", recursive = TRUE)

#Reads text lines from the path to file
readLines("Data/wide_income.csv")
#readLines can open a file, head() cannot
income = read.csv("Data/wide_rent_income.csv" )
#To read in some csv data
test.data<-read.csv("")

#Name of file needs to be in quotations
test.data
#It will show the data in the console
#always check to see what the data looks like to make sure R read it right
#specify an area of a larger piece of data to check
#'head()' lets us look at the top
head(test.data)
#'tail()' lets us look at the bottom
tail(test.data)


####Regular Expressions####
# ^ means 'starts with
#use chatgbt, just ask "make me a regular expression for ''"


####For-loops####
for(i in bfiles){
  readLines()
}


# Write a for-loop that prints the results of 1+x (each of those numbers)

x <- c(1,2,3,4,5) #This is a numeric vector, aka, it's class)

for(i in x){
  print(i+1)
}

#R is vectorized (vector is one-dimensional) so 
x + 1 #will give the same behavior
x^3

c() #concatinates everything inside
1:5 #(all numbers between)
seq(1:100)
seq(1,100, by = 2)

class(x)
length(x)
length(length(x))

#R treats objects differently depending on what class it is
#Character vs numeric vs logical, integer, data.frame
#Everything in a vector has to be the same class, R will change an object's class to whatever
#the majority class (if there is a character, it will characterize everything no matter)

#length of a vector can be 0
length(c())

1:5 + 1:5 #1+1, then 2+2, then 3+3, etc)
#matrix math is built into R, not Python

a <- 1:10
b <- 2:11
c <- letters[1:10] #letters[c(1,3,5)] if you want to specify in one dimension
head(letters,n=10)

a
b
c
cbind(a,b,c)
d <- rep(TRUE, 10)
z <- data.frame(a,b,c,d)
#this is a data frame, only works if every item is the same length (makes a spreadsheet)

class(z)
length(z)
dim(z)
#data is a list of vectors, and each separate vector can have its own class, as long as
#internally each vector is one class.

####Logical class errors####
1 > 0
0 >= 0
3 < 1
1 == 1
1 != 1
5 > a #Does for every object in a vector
z[,1]

a[5 > a]
#If you put a logical inside brackets, it will just give you where everything is true

z[5 > a,]
#This works because it is saying (row, column). So you are asking for all of column a.

z["b" == c,]

#Find rows where Sepal.Length is greater than 5
iris$Sepal.Length > 5 #This returns a vector
iris[iris$Sepal.Length > 5,] #This will give me only the rows that a true


dim(iris[iris$Sepal.Length > 5,])
nrow(iris[iris$Sepal.Length > 5,])
dim(iris[iris$Sepal.Length > 5,])[1]


big_iris <- iris[iris$Sepal.Length > 5,]
#add a new column that is equal to sepal length * sepal width (sepal_area)

big_iris$Sepal_Area <- big_iris$Sepal.Length * big_iris$Sepal.Width
#This will add the new assignment and make it a column in the data

#Find just the setosa species from the big iris
big_setosa <- big_iris[big_iris$Species == "setosa",]

#show the mean of sepal area of big setosa
mean(big_setosa$Sepal_Area)
cumsum()
cumprod()

summary(big_setosa$Sepal_Area)

#plotting
plot(big_setosa$Sepal.Length, big_setosa$Sepal.Width, col="blue")
plot(big_setosa$Sepal.Length, big_setosa$Sepal.Width, col="blue",
     main= "Petal Length times Petal Width", ylab="Petal Width (cm)",
     xlab="Petal Length (cm)", pch=23)



# mtcars ####

# Build a data frame from mtcars with only rows that have
# more than 4 cylinders (cyl)

df <- mtcars[mtcars$cyl > 4,]

#2.
# Pull out just the miles per gallon of those cars (mpg)
# and find the mean, min, and max

mean(df$mpg)
max(df$mpg)
min(df$mpg)



# Notes ####
## Object Types ####
### Logical ####
c(TRUE, FALSE, FALSE)
### Numeric ####
1:10
### Integer ####
c(1L, 2L, 3L)
### Character ####
letters[3]
### Data.frame ####
mtcars[rows, cols]

str(mtcars)
names(mtcars)
mtcars[,"mpg"]

### Factor ####
# annoying but useful
# you can control order, so they are ordered correctly when graphing
# like ordering by "low", "medium", "high"

as.factor(letters) # categorical type data, 
# stores as data in levels
# everything in the whole set must be found at these levels

haircolors <- c("brown", "blonde", "black", "red", "red", "black")
as.factor(haircolors)
c(as.factor(haircolors), "purple")
as.numeric(as.factor(haircolors), "purple") # ignores purple
as.character(as.factor(haircolors), "purple")

# see what levels are possible
levels(haircolors)

## Type Conversions ####
1:5 # numeric
as.character(1:5) # convert to character
as.numeric(letters) # It tries 
NA # means 'Not There'

c("1", "b", "35")
as.numeric(c("1", "b", "35")) # will try for values it can
# but will give NA for values it can't assign as numeric

as.logical(c("True", "t", "F", "False"))
as.logical(c("True", "t", "F", "False", "T"))

as. # has a host of things that you can turn an object into
# might not always work

x <- as.logical(c("True", "t", "F", "False", "T"))
sum(x)
sum(TRUE)
TRUE + TRUE
FALSE + 3
NA + 2 # makes an NA, because it is 'missing' data
# doesn't know what to do until told
# aka if there is any NA, the answer will be NA
sum(x, na.rm = TRUE)



## Data.frame ####
str(mtcars)
names(mtcars)
mtcars[,"mpg"]

# for-loop assings each character version of every column over itself
for (col in names(mtcars)) {
  mtcars[,col] <- as.character(mtcars[,col])
}
str(mtcars)
data("mtcars") # resets built in data frame
str("mtcars") # now it is back to numeric

df1 <- read.csv("./Data/cleaned_bird_data.csv")

# convert all columns to character
for (col in names(df1)){
  df1[,col] <- as.character(df1[,col])
}

str(df1)

# How to save data.file back to your computer
write.csv(df1, file = "./Data/cleaned_bird_data_chr.csv")
# must add something to file name, it will save over old doc
# without asking
# everytime you clean data the OG file is read only
# NEVER CHANGE OG FILE

## 'apply' family functions ####
apply(mtcars,2,as.character) # easier than for-loop but less customizable
apply(mtcars,2,as.logical) 
apply(mtcars,2,as.factor)
# 1 is row
# 2 is column

lapply()
sapply()
vapply()

# Packages ####
## Tidyverse ####
library(tidyverse)
# MUST LOAD IN TIDYVERSE EVERYTIME
# helps filter our subset data frames by rows

stats::filter() # this will give you a function from a specific package
dplyr::filter()

mtcar %>%
  filter(mpg > 19)

?filter

# '%>%' this is called a pipe, the thing on the left
# side of the pipe becomes the first argument to thing on right
mtcars$mpg %>% mean()

# a lot faster than
abs(mean(mtcars$mpg))
mtcars %>%
  mean() %>%
  abs()


mtcar %>%
  filter(mpg > 19 & vs == 1) # can give multiple conditions


#1/25/24####

#subset this penguins data frome to only those obsevations where bill_length_mm >40
library(tidyverse)
library(palmerpenguins)

bill.length <- penguins %>%
  filter(bill_length_mm>40& sex== "female",)
#find mean body mass
bill.length$body_mass_g%>%mean


#find mean body mass of female long-beaked penguins
 penguins %>%
  filter(bill_length_mm>40 & sex== "female",) %>%
  pluck("body_mass_g") %>%
  mean

 # find the mean,max,min, n, but for each species####
 ## Functions: Summarize, group_by,arrange####
 penguins %>%
   filter(bill_length_mm>40 & sex== "female",) %>%
  group_by(species,island )%>% #commas to seperate all groupings
   summarize(mean_body_mass= mean(body_mass_g),
             min_body_mass=min(body_mass_g),
             max_body_mass=max(body_mass_g),# these functions are best for statistical point estimates
             sd_body_mass=sd(body_mass_g),
             N=n()) %>%
 arrange(desc(mean_body_mass)) %>% #desk needs to be inside a arrange function
   write_csv("./Data/penguin_summary.csv")
 
 ###practice of functions####
 # Find the fattie penguins (body_mass >5000)
 #count how many are male and how many are female
 #return the max body mass for mels and females
 #bonus: add new column to penguins that says whether they're a fattie
 
 penguins %>%
   filter(body_mass_g>5000,) #filter is for selecting rows
 
 penguins %>%
   filter(body_mass_g>5000,)%>%
   group_by(sex)%>%
   summarize(N=n(),
           max_body_mass=max(body_mass_g))
penguins %>%
  mutate(fattie=body_mass_g >5000) #changing columns, making new columns based on existing stuff

x <- 
  penguins %>%
  mutate(fatstat=case_when(body_mass_g >5000 ~ "fattie",
                          body_mass_g <=5000 ~ "skinny")) #case_when() only works in mutate. logical expression and give condition####

#plotting####
x %>%
  ggplot(mapping=aes(x=body_mass_g, y=bill_length_mm, color=fatstat, shape=fatstat)) +
  geom_point() +
  geom_smooth() +
  scale_color_manual(values=c("turquoise","salmon"))+
  theme_dark()+
  theme(axis.text=element_text(angle=180, face= "italic"))
  #scale_color_viridis_d(option='plasma',end=.8) #viridis is color blind friendly, d is for discrete

#1/30/24####
library(tidyverse)
#type the followin in pipe format
#unique(stringr::str_to_title(iris$Species))
  iris %>%
  pluck("Species")%>%
  stringr::str_to_title()%>%
  unique()
  
  #max(round(iris$Sepal.Length),0)
  iris %>% 
    pluck("$epal.Length") %>% 
    round() %>%
    max()
  #mean(abs(rnorm(100,0,5)))
  seq(100,0,r) %>% 
    rnorm() %>%
    mean()


  ##ggplot2::calling without loading package  (two colons are called the namespace)####
  ##plotting again####
  library(ggplot2)
  names(penguins)#tells you the comulmn names
  ggplot(penguins,mapping=aes(x=flipper_length_mm,
                              y=body_mass_g, color=species,alpha=bill_depth_mm)) +
#geom_line(aes(group=species))
  #geom_col() bar chart in ggplot

geom_path(aes(group=species))+stat_ellipse() + geom_point(aes(color=sex))+ geom_polygon()+geom_hex()+ geom_bin_2d()+geom_boxplot() + geom_hline(yintercept=4500,linewidth=5,color='magenta',linetype='1121',alpha=.25)+geom_point(color='yellow',aes(alpha=bill_depth_mm))+ theme(axis.title = element_text(face = 'italic',size=12,angle=30),legend.background=element_rect(fill="hotpink",color="blue",linewidth=5))
  
  
  
  
  #1 on 1 off two on one of
  #one layer covers the next
  #alpha controls transparency
  
  #aes() is for mapping a whole column toa desired esign type, whereas outside of aesthetic it is simply talking about the data given####
  
  ##Leaflet package: good to know####
  library(leaflet)
  m <- leaflet() %>%
    addTiles() %>%  # Add default OpenStreetMap map tiles
    addMarkers(lat=40.38331524371686, lng=-111.83779529469302, popup="Rosie's parents house")
  

#2/1/2024####
  library(tidyverse)
  library(palmerpenguins)
# make an interesting plot of the penguin data
  penguins%>%
    ggplot(mapping=aes(x=bill_length_mm,y=bill_depth_mm,
                       color=species,group_by(species)))+
             geom_point()+
  stat_ellipse()
  

  #class notes#
  penguins %>% ggplot(aes(x=species,
                          y=body_mass_g))+
    geom_boxplot()+
    geom_jitter(height=0,width=.1,alpha=.2) #geom_jitter: adds a small amount of random variation to the location of each point####

  ###Desnsity plot in ggplot####
  penguins%>%
    ggplot(aes(x=body_mass_g,fill=species))+
    geom_density(alpha=.25
                 )
  ###histogram in ggplot####
  penguins%>%
    ggplot(aes(x=body_mass_g,fill=species))+
    geom_histogram(alpha=.25)
#PLOTTING rules: 1. don't hide your data, 2. have a goal, 3. plot before running stats####  

##reding not csv files####
df <- read_delim("./Data/DatasaurusDozen.tsv")

  df%>%
    group_by(dataset)%>%
    summarise(meanx=mean(x),
              sdx=sd(x),
              minx=min(x),
              medianx=median(x))
df%>%
  ggplot(aes(x=x,y=y))+
  geom_point()+
  facet_wrap(~dataset)


###ggpairs()####
library(GGally)
ggpairs(penguins)

#bill depth and body mass
penguins%>%
  filter(!is.na(sex))%>%
  ggplot(aes(x=bill_depth_mm,y=body_mass_g,color=species))+
  geom_point()+
  facet_wrap(~island,scales="free")+
  geom_smooth()+
  labs(x="Bill Depth (mm)",y="Body mass(g)") 

###within facet you can let each x axis have it's one number scales, you would you scales insieof facetwraps####


#2/6/24####
#xkcd pacakge makes stickfigure plots

library(tidyverse)
library(ggimage)
library(gganimate)
library(patchwork)#lets you stick plots together however you want####
library(gapminder)

names(gapminder)
str(gapminder)  

df <- gapminder

p<-df%>%
  ggplot(mapping=aes(x=lifeExp,y=pop,color=continent,))+
  geom_point()
  #facet_wrap(~continent,scales="free")#plots are saved as lists

p2 <- p+facet_wrap(~continent)

df$year%>% range


mycountries <- c("Venezuela","Rwanda","Nepal","Iraq","Afghanistan","United States")

df <- 
df %>%
  mutate(mycountries=case_when(country %in% mycountries ~country))#create new column with only stuff you care about####




p3 <- 
  ggplot(df,
         aes(x=gdpPercap,y=lifeExp,color=continent))+
  geom_point(aes(size=pop))+
  geom_text(aes(label=mycountries))


p3+
  transition_time(time=year)+
  labs(title='Year: {frame_time}')##animated plot showing change over time with the year####
ggsave("./Notes/plot_example.png",width=3,height = 3,dpi=200)###saves an image no animation, dpi is the resolution, 300 ins the min for printing####

anim_save("./Notes/gapminder_animation.gif")#exporting animation

p/p2 + plot_annotation(title="Comparing with and without facets")

p.dark<- p+theme_dark()

p+p.dark

p / p.dark

(p+p.dark)/p.dark+plot_annotation("Main Title")
patchwork::plot_layout(guides='collect')


#2/8/2024####

library(tidyverse)
#load this data set
df <- read.csv("./Data/wide_income_rent.csv")
#plot rent prices for each state..
#state on x-axis, rent on y-axis, bar chart

df2= as.data.frame(t(df))
df2 <- df2[-1,]
df2$State <- row.names(df2)
names(df2) <- c("rent","income","State")

##pivot functions for untidy datasets####
###pviot longer if one ariable is accross multiple columns####
###pivot wider if multiple variables are in a single column####
library(tidyverse)
df %>%
  pivot_longer(-variable,names_to = "state",values_to = "amount") %>%
  pivot_wider(names_from = variable,values_from = amount)%>%
  ggplot(aes(x=state,y=rent,))+
  geom_col()+
  theme(axis.text.x=element_text(angle=90, hjust=1,vjust=.5,size=6))



table1
####rows should be 1 observation####
#get table 2 to look likw table1
table2 %>%
  pivot_wider(names_from = type,values_from=count)

table3%>%
  separate(rate, into=c("cases", "population"))##Seperate function####


##Join functions####
x <- table4a%>%
  pivot_longer(-country, names_to = "year", values_to="cases")

y <- table4b%>%
  pivot_longer(-country, names_to = "year", values_to="population")


full_join(x,y)

##seperate, mutuate, paste example####
table5 %>%
  separate(rate, into=c("cases","population"),convert=TRUE) %>%
  mutate(year=paste0(century,year)%>% as.numeric())%>%
  select(-century)
  #paste0 is for wanting no spaces between


library(readxl)
dat <- read_xlsx("./Data/messy_bp.xlsx",skip=3)
library(tidyverse)
bp <- 
  dat %>%
  select(-starts_with("HR"))

bp<- bp%>%
  pivot_longer(starts_with("BP"), names_to = "visit", values_to = "bp")%>%
  mutate(visit=case_when(visit == "BP...8"~1,
                         visit == "BP...10"~2, 
                         visit == "BP...12"~3)) %>%
  separate(bp, into=c("systolic","diastolic"))



hr <- 
  dat %>%
  select(-starts_with("BP"))

hr<- hr%>%
  pivot_longer(starts_with("HR"), names_to = "visit", values_to = "hr")%>%
  mutate(visit=case_when(visit == "HR...9"~1,
                         visit == "HR...11"~2, 
                         visit == "HR...13"~3)) 


df <- full_join(bp,hr)
#02/13/24####
#cleanup stuff
library(janitor)
janitor::clean_names()##janiotr cleans names so they look better ####
df <- df%>%
  clean_names()

#make_clean_names("# caucasian")#makes clean names based from symbols

df$race%>% unique

df <- 
df%>% mutate(race=case_when(race == "Caucasian" | race == "WHITE"~ "White",
                             TRUE~df$race))%>%
  mutate(birthdate=paste(year_birth,month_of_birth,day_birth,sep= "-")%>% as.POSIXct()) %>%
  mutate(systolic=systolic%>%as.numeric(),
         diastolic=diastolic%>% as.numeric())%>%
  select(-pat_id,-month_of_birth,-day_birth,-year_birth) %>%
  mutate(hispanic=case_when(hispanic=="Hispanic"~TRUE,
                            TRUE~FALSE))%>%
  pivot_longer(cols=c("systolic","diastolic"),names_to="bp_type",values_to="bp")

### changing name of elements in a column but if the other elements are fine make the same as the original####
  
###as.POSIXct understands leap years, nanoseconds ect####


##year is understood as "2023-02-03 year month day"####
#### %>%unique looks for unique values in column####
 
df%>%
  ggplot(aes(x=visit,y=hr,color=sex))+
  geom_path()+
  facet_wrap(~race)
 
df%>%
  ggplot(aes(x=visit,y=bp,color=bp_type))+
  geom_path()+
 facet_wrap(~race)

#2/15/24####
##More Messy Data cleanup####
library(tidyverse)
library(skimr)
library(janitor)
skim(df) ###skimmr tealls you usful things about a dataframe quickly####

#pivot_longer(cols=c("systolic","diastolic"),names_to="bp_type",values_to="bp")
#pivot_longer(starts_with("HR"), names_to = "visit", values_to = "hr")
df <- read_csv("./Data/Bird_Measurements.csv")
keepers<- c("Family", "Species_number","Species_name","English_name","Clutch_size","Egg_mass", "Mating_System")%>% str_to_lower()

male <- 
  df%>%
  clean_names()%>%
select(keepers,starts_with("m_"), -ends_with("_n"))%>%
  mutate(sex="male") %>% view() 
names(male) <- names(male)%>% str_remove("m_")

female <- 
  df%>%
  clean_names()%>%
  select(keepers,starts_with("f_"), -ends_with("_n"))%>%
  mutate(sex="female") %>% view()
names(female) <- names(female)%>% str_remove("f_")

unsexed <- 
  df%>%
  clean_names()%>%
  select(keepers,starts_with("unsexed_"), -ends_with("_n"))%>%
  mutate(sex="unsexed") %>% view()
names(unsexed) <- names(unsexed)%>% str_remove("unsexed_")

clean <- male.female <- male %>% 
  full_join(female) %>% 
  full_join(unsexed)



#sorst data storage ever
library(readxl)

x <- read_xlsx("/Users/rosie/Downloads/Worst Data Storage Ever.xlsx",shee=1, range="A1:K10")
#play with this dataset  





#2/20/24####
library(readxl)
dat <- read_xlsx("./Data/messy_bp.xlsx",skip=3)
library(tidyverse)
bp <- 
  dat %>%
  select(-starts_with("HR"))
names(bp)
 
n.visits <- bp %>% 
  select(starts_with("BP")) %>% 
  length()
1:n.visits ##count's the numbe of visits no matter how many cols####

which(grepl("^BP",names(bp)))##grepl looks for a pattern and returns a true false####

names(bp)[which(grepl("^BP",names(bp)))] <- paste0("visit",1:n.visits)###toegher that is saying which of the names of bp start with bp

bp<- 
  bp%>%
  pivot_longer(starts_with("visit"), 
               names_to = "visit", 
               values_to = "hr",
               names_prefix = "visit",
               names_transform = as.numeric) %>% 
  separate(bp, into=c(systolic, diastolic))
  
  n.visits <- hr %>% 
  select(starts_with("HR")) %>% 
  length()
1:n.visits ##count's the numbe of visits no matter how many cols####

which(grepl("^HR",names(hr)))##grepl looks for a pattern and returns a true false####

names(hr)[which(grepl("^HR",names(hr)))] <- paste0("visit",1:n.visits)###toegher that is saying which of the names of bp start with bp
hr<- 
  hr%>%
  pivot_longer(starts_with("visit"), 
               names_to = "visit", 
               values_to = "hr"
               names_prefix = "visit",
               names_transform = as.numeric)


#a great package to interact with databases is dbplyer####

##hext sticke r package makes hex stickers####

###mesaurements package####
library(tidyverse)
library(measurements)
x <- c(12,31,44)
measurements::conv_unit(x,from='inch',to='feet')
measurements::conv_unit(x,from='inch', to='parsec')

#02/22/2024####

#live datafixing##
library(readxl)
#file.copy("~/Desktop/data don't delete/CW_CameraData_2019.xlsx","./Desktop/data don't delete/CW_CameraData_2019.xlsx)
path <- "/Users/rosie/Desktop/data don't delete/CW_CameraData_2019.xlsx"
sites <- c("South Oak Spring Site 2",
           "North Oak Spring Site 1",
           "Oak Spring", 
           "North Tickville Site 1",
           "South Tickville Site 3",
           "Tickville",
           "Redwood Road Underpass",
           "Water Fork Rose Canyon Spring")

sites[1] %>% str_replace_all(" ","_")



South_Oak_Spring_Site_2<- 
  read_trap_data(path=path,
               sheet=sites[1],
               range1="B17:I17",
               range2 = "A2:I12")



 North_Oak_Spring_Site_1 <- 
   read_trap_data(path=path,
                   sheet=sites[2],
                   range1="B15:I15",
                   range2 = "A2:I12")
 
 Oak_Spring <-    read_trap_data(path=path,
                                 sheet=sites[3],
                                 range1="B18:I18",
                                 range2 = "A2:I15")

 
 North_Tickville_Site_1 <- read_trap_data(path=path,
                                          sheet=sites[4],
                                          range1="B14:I14",
                                          range2 = "A2:I11")
 South_Tickville_Site_3 <-  read_trap_data(path=path,
                                           sheet=sites[5],
                                           range1="B13:I13",
                                           range2 = "A2:I10")
 Tickville <-  read_trap_data(path=path,
                              sheet=sites[6],
                              range1="B14:I14",
                              range2 = "A2:I11")
 Redwood_Road_Underpass <- read_trap_data(path=path,
                                          sheet=sites[7],
                                          range1="B15:F15",
                                          range2 = "A2:F12")
 Water_Fork_Rose_Canyon_Spring <- read_trap_data(path=path,
                                                 sheet=sites[8],
                                                 range1="B21:J21",
                                                 range2 = "A2:J16")
 
 sites %>% str_replace_all(" ","_")
 South_Oak_Spring_Site_2 %>% 
   full_join(South_Tickville_Site_3) %>% 
   full_join(North_Oak_Spring_Site_2) %>% 
   full_join(North_Tickville_Site_1)
 


read_trap_data <- 
function(path,sheet,range1,range2){
trap_days <- 
  read_xlsx(path,sheet=sheet,range=range1, col_names=FALSE)

library(janitor)
x <- 
  read_xlsx(path,sheet=sheet, range=range2) %>% 
  clean_names() %>% 
  mutate(across(-species,as.numeric())) %>% 
  pivot_longer(-species, names_to="month",values_to="obs_count") %>% 
  mutate(site=sheet,
         month=str_to_sentence(month),
         species=str_to_sentence(species)) %>% 
  mutate(month=case_when(str_detect(month,"[J,j]an")~"January",
                                   str_detect(month,"[F,f]eb")~"February",
                                   str_detect(month, "[M,a]ar")~"March",
                                   str_detect(month, "[A,a]pr")~"April",
                                   str_detect(month,"[M,m]ay")~"May",
                                   str_detect(month,"[J,j]un")~"June",
                                   str_detect(month,"[J,j]ul")~"Jul",
                                   str_detect(month,"[A,a]ug")~"August",                                               str_detect(month,"[S,s]ep")~"September",                                            str_detect(month, "[O,o]ct")~"October",                                             str_detect(month, "[N,n]ov")~"November",                                            str_detect(month, "[D,d]ec")~"December"))

x <- 
x %>% 
full_join(
  data.frame(month=x$month %>% unique,
  trap_days=trap_days[1,] %>% as.numeric())
)
return(x)
}
  

#02/27/24####
# SETUP ####
library(tidyverse)
library(readxl)
library(measurements)

# DATA ####
path <- "./Notes/human_heights.xlsx"
dat <- read_xlsx(path)

# CLEAN ####
dat <- 
  dat %>% 
  pivot_longer(everything(),
               names_to = "sex",
               values_to = "height") %>% 
  separate(height, into = c("feet","inches"),convert = TRUE) %>% 
  mutate(inches = (feet*12) + inches) %>% 
  mutate(cm=conv_unit(inches, from='in',to='cm'))

dat %>% 
  ggplot(aes(x=cm,fill=sex)) +
  geom_density(alpha=.5)#distirbution density plot

t.test(dat$cm~factor(dat$sex))##t-test using formula####
 #formula with t-testlhs: left has side, rhs: is right hand side

mod <- glm(data=dat,formula=cm~sex)#generalized linear model
summary(mod)


library(easystats) ##Easystats LIFE SAVING PACKAGE####
report(mod)
performance(mod)#gives RMSE and R^2, AIC, AICc, BIC, and Sigma, RSME is a statistical distance
performance::check_model(mod)###Does model checks using check_model####

library(tidyverse)
mpg %>% ggplot(aes(x=displ,y=cty))+
  geom_point()+
  geom_smooth(method='glm')#pipe to do glm modeling type
glm(data=mpg,
    formula=cty~displ) %>% summary()

library(tidyverse)
data.frame(A=rnorm(10,mean=0,sd=1),
           B=rnorm(10,mean=5,sd=1)) %>% 
  pivot_longer(everything()) %>% 
  ggplot(aes(x=value,fill=name))+
  geom_density()
  



#02/29/24####

#use mpg
#build a model that predicts cty as a function of displ
library(tidyverse)
library(easystats)
library(MASS)

mod1 <- glm(data=mpg,formula=cty~displ)

mod1$residuals #residuals is distance from predictor line for each point

mod2 <-glm(data=mpg,formula=cty~displ+cyl)

mod3 <- glm(data=mpg,formula=cty~displ*cyl)#influcence of displacement on city can depend on cylinder



#add new column indicating whether automatic
mpg <- 
mpg %>% mutate(auto=grepl("auto",mpg$trans))

mod4 <- glm(data=mpg,formula=cty~displ*cyl*auto)

mod5 <- glm(data=mpg,formula=cty~displ+year+cyl*trans*drv*fl+class)
formula(mod5)

step <- stepAIC(mod5)##Removing variable in model if they aren't significant#####
#step

mod_best <- glm(data=mpg,formula=formula(step))

summary(mod4)

compare_models(mod1,mod2,mod3,mod4,mod_best)
compare_performance(mod1,mod2,mod3,mod4,mod_best)#AIC smaller is better penalizes you for unimportant predictors USE WITH CAUTION####

compare_performance(mod1,mod2,mod3,mod4,mod_best) %>% plot ##plotting performance of models####


mpg$pred <- predict(mod1,mpg)
mpg$pred2 <- predict(mod2,mpg)
mpg$pred3 <- predict(mod3,mpg)
mpg$predbest <- predict(mod_best,mpg)


mpg %>% 
  pivot_longer(starts_with("pred")) %>% ggplot(aes(x=displ,y=cty,color=factor(cyl)))+
  geom_point()+
  geom_point(aes(y=value),color='black')+
  facet_wrap(~name)#plot coloring by cylinder factor, the black is looking at the predicted y values compared to the actual





mpg %>% 
  ggplot(aes(x=cty,y=pred))+
  geom_point() #if modely was perfict you'd see a 1 to 1 straight line


mpg %>% 
  ggplot(aes(x=cty,y=pred2))+
  geom_point()

mpg %>% 
  ggplot(aes(x=cty,y=pred3))+
  geom_point()

mpg %>% 
  ggplot(aes(x=cty,y=predbest))+
  geom_point()

predict(mod1,data.frame(displ=1:100))#gave model 1 through 100 and pridicted cty mpge



mpg %>% 
  ggplot(aes(x=displ,y=cty))+
  geom_smooth(method="glm") #mod1

mpg %>% 
  ggplot(aes(x=displ,y=cty,color=factor(cyl)))+
  geom_smooth(method="glm")#mod3





check_model(mod3)#tells if you model is meeting these assumptions####



##03/05/24####
library(tidyverse)
library(easystats)
library(palmerpenguins)
#does body_mass_g vary significantly between penguin species?
mod <- glm(penguins$body_mass_g~penguins$species)#adelie is the intercept because it's alphabecical, if you want something else to be your intercept set it as a factor and set your levels
summary(mod)


##preditc whether a species is "Gentoo" based on size measurements
names(penguins)

##Logistic Regression, binaray outcome, family=binomial, type=response####
mod2 <- penguins %>% 
  mutate(gentoo=case_when(species=="Gentoo"~TRUE,
                         TRUE~FALSE)) %>% 
  glm(data=.,
      formula=gentoo~bill_depth_mm+body_mass_g+flipper_length_mm+bill_length_mm,family='binomial')###dot represents the thing I piped#### 

####family argument gives distirbution, default is gaussian for logistic it needs to be binomial###

summary(mod2)
check_model(mod2)
predict(mod2)###logodds
penguins$pred <- predict(mod2,penguins,type='response')###logistic regression use type='response', gives percentages####


penguins %>% 
ggplot(aes(x=body_mass_g,y=pred,color=species))+
  geom_point()

preds <- 
  penguins %>% 
  mutate(outcome=case_when(pred<0.01~ "Not gentoo",
                           pred>.75~"Gentoo")) %>% 
  select(species,outcome) %>% 
  mutate(correct=case_when(species == "Gentoo" & outcome=="Gentoo"~ TRUE,
                           species != "Gentoo" & outcome== "Not gentoo"~TRUE,
                           TRUE~FALSE))
preds %>% 
  pluck("correct") %>%
  sum()/nrow(preds)


dat <- read_csv("./Data/GradSchool_Admissions.csv")
str(dat)
mod3 <- glm(data=dat,
            formula=as.logical(admit)~(gre+gpa)*rank,
            family='binomial')
dat$pred <- predict(mod3,dat,type='response')

dat %>% 
  ggplot(aes(x=gpa,y=pred,color=factor(rank)))+
  geom_point(alpha=.25)+
  geom_smooth()

dat %>% 
  ggplot(aes(x=factor(rank),y=pred,color=factor(rank)))+
  geom_jitter(alpha=.25)+
  geom_boxplot()+
  geom_smooth()


library(keras)#machine learning on pictures
#tidymodels package gooed for machine learning

