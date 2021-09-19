library(ggplot2)
setwd('C:/Users/jgolba/Documents/DSC 520 - Stats for Data Science/dsc520/data/')
ACS <- read.csv(file="acs-14-1yr-s0201.csv")
head(ACS)

#i What are the elements in your data (including the categories and data types)?
summary(ACS)

#ii Please provide the output from the following functions: str(); nrow(); ncol()
str(ACS) 
###'data.frame':	136 obs. of  8 variables:
#$ Id                    : chr  "0500000US01073" "0500000US04013" "0500000US04019" "0500000US06001" ...
#$ Id2                   : int  1073 4013 4019 6001 6013 6019 6029 6037 6059 6065 ...
#$ Geography             : chr  "Jefferson County, Alabama" "Maricopa County, Arizona" "Pima County, Arizona" "Alameda County, California" ...
#$ PopGroupID            : int  1 1 1 1 1 1 1 1 1 1 ...
#$ POPGROUP.display.label: chr  "Total population" "Total population" "Total population" "Total population" ...
#$ RacesReported         : int  660793 4087191 1004516 1610921 1111339 965974 874589 10116705 3145515 2329271 ...
#$ HSDegree              : num  89.1 86.8 88 86.9 88.8 73.6 74.5 77.5 84.6 80.6 ...
#$ BachDegree            : num  30.5 30.2 30.8 42.8 39.7 19.7 15.4 30.3 38 20.7 ...
nrow(ACS) 
# 136
ncol(ACS) 
#8

#iii Create a Histogram of the HSDegree variable using the ggplot2 package.
  #1. Set a bin size for the Histogram.
  #2. Include a Title and appropriate X/Y axis labels on your Histogram Plot.
ACS_Historgram <- ggplot(ACS, aes(HSDegree)) + geom_histogram(bins=30) + 
  ggtitle('Percent of Population to Receive High School Degree') + 
  xlab('HS Degrees Achieved in Percent') + ylab('Frequency')
ACS_Historgram

#iv Answer the following questions based on the Histogram produced:
  #1 Based on what you see in this histogram, is the data distribution unimodal? No
  #2 Is it approximately symmetrical? No
  #3 Is it approximately bell-shaped? No
  #4 Is it approximately normal? No
  #5 If not normal, is the distribution skewed? If so, in which direction? Left skewed
  #6 Include a normal curve to the Histogram that you plotted.
ACS_Historgram + stat_function(fun=dnorm, args=list(mean=mean(ACS$HSDegree, na.rm = TRUE), sd=sd(ACS$HSDegree, na.rm = TRUE)), color = 'blue', size = 1)
  #7 Explain whether a normal distribution can accurately be used as a model for this data.
  ## Because the ACS data is skewed to the left, a normal distribution cannot be used.  

#v Create a Probability Plot of the HSDegree variable.
ggplot(ACS, aes(sample=HSDegree)) + stat_qq() + stat_qq_line(color = 'red')

#vi Answer the following questions based on the Probability Plot:
  #Based on what you see in this probability plot, is the distribution approximately normal? Explain how you know.
    #The distribution is not normal because the plot is not straight.
  #If not normal, is the distribution skewed? If so, in which direction? Explain how you know.
    #Both ends of the plots are below the line so it is skewed left.

#vii Now that you have looked at this data visually for normality, you will now 
#quantify normality with numbers using the stat.desc() function. Include a 
#screen capture of the results produced.
library(pastecs)
options(scipen=100)
options(digits=3)
stat.desc(ACS, basic=TRUE, desc=TRUE, norm=FALSE, p=0.95)
stat.desc(ACS$HSDegree, basic = FALSE, norm = TRUE)

#viii In several sentences provide an explanation of the result produced for 
#skew, kurtosis, and z-scores. In addition, explain how a change in the sample 
#size may change your explanation?
#With the skewness being -1.67, the data is skewed to the left.
#The kurtosis is 4.35 so the data has a heavy tailed distribution.
#The z-scores for skew and kurtosis are rather large showing little relationship to the mean.
#A larger sample size would give us more data to analyze and possibly make the distribution more normal.

