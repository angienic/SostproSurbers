library(dplyr)
#Trying quick density per taxon
Bugs<-read.csv ("C:\\Users\\nicangie\\Documents\\Ang\\Projects_and_Samples\\SOSTPRO\\Surbers\\CleanBugsforRdensity.csv",
                colClasses=c(rep("factor",6),rep("integer",135))) #for total of 141 columns, without this R assigned columns 'Goeracea'and 'Agrylea' as logic (all 0,1s), so reclassify:
#Remove NAs
Bugs[is.na(Bugs)] <- 0
#Mariella's vials 81,83,90 were entered as R3_1, but should be R3_I:
Bugs$Site[Bugs$Site=="R3_1"] <-"R3_I" 
#Counting surbers per site, worked! :) 
Surber_n <- Bugs %>%
  group_by(Site) %>%
  summarise(n = n())

write.csv(Surber_n, file="output_data/Surber_n.csv",
          row.names=FALSE)

#Total individuals per surber #worked!
Taxa_sum<-Bugs%>%
  group_by(Site) %>%
  summarise_if(is.numeric, sum)

#
Bugs %>%
group_by(Site) %>%
  summarise_if(is.numeric, average= Taxa_sum/(Surber_n$n)) #doesn't work

#Alternatively add column Surber_n to Bugs
Taxa_sum$nSurber<- Taxa_sum %>%
  group_by(Site) %>%
  summarise(n = n())  

#Check 'chaining' for passing results of one function to another https://www3.nd.edu/~steve/computing_with_data/24_dplyr/dplyr.html



#Surber size 30*30cm