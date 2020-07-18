library(dplyr)
#Trying quick density per taxon
Bugs<-read.csv ("C:\\Users\\nicangie\\Documents\\Ang\\Projects_and_Samples\\SOSTPRO\\Surbers\\CleanBugsforRdensity.csv",
                colClasses=c(rep("factor",6),rep("integer",135))) #for total of 141 columns, without this R assigned columns 'Goeracea'and 'Agrylea' as logic (all 0,1s), so reclassify:
#Remove NAs
Bugs[is.na(Bugs)] <- 0
#Mariella's vials 81,83,90 were entered as R3_1, but should be R3_I:
Bugs$Site[Bugs$Site=="R3_1"] <-"R3_I" 
#Counting surbers per site, worked! :) tdbit form
Bugs %>%
  group_by(Site) %>%
  summarise(n = n())

#
Surber_n <- Bugs %>%
  group_by(Site) %>%
  summarise(n = n())

#Total individuals per surber (below here to check)
#worked!
Bugs%>%
  group_by(Site) %>%
  summarise_if(is.numeric, sum)

#Surber size 30*30cm