#### *** Sostpro 2018 Invertebrate density per site *** ###
#A.Nicolas-July 21, 2020.

library(dplyr)

####################             Interior      #########################################
Bugs_Interior<-read.csv ("C:\\Users\\nicangie\\Documents\\Ang\\Projects_and_Samples\\SOSTPRO\\Surbers\\CleanBugsforRdensity_Interior.csv",
                colClasses=c(rep("factor",6),rep("integer",135))) #for total of 141 columns, without this line R assigned columns 'Goeracea'and 'Agrylea' as logic (all 0s,1s).

#Interior
####Data cleaning:
#Remove NAs
Bugs_Interior[is.na(Bugs_Interior)] <- 0
#Mariella's vials 81,83,90 were entered as R3_1, relabel to R3_I:
Bugs_Interior$Site[Bugs_Interior$Site=="R3_1"] <-"R3_I" 
#Note that R removed last part of a variable name after a character.Ex: Trichop.dam/juv becomes Trichop.dam
#### Counting surbers processed per site
Surber_n_Interior <- Bugs_Interior %>%
  group_by(Site) %>%
  summarise(n = n())
write.csv(Surber_n_Interior, file="output_data/Surber_n_Interior.csv",row.names=FALSE)

### Calculating total indiv. of each taxon per surber
Taxasums_Interior<-Bugs_Interior%>%
    group_by(Site) %>%
    summarise_if(is.numeric, sum)
    inner_join(Bugs_Interior,Surber_n_Interior, by='Site')
  write.csv(Taxasums_Interior, file="output_data/Taxasums_Interior.csv",row.names=FALSE)   
  
  Taxasums_Interior<-data.frame(read.csv("C:\\Users\\nicangie\\Documents\\Ang\\Projects_and_Samples\\SOSTPRO\\Surbers\\output_data/Taxasums_Interior.csv"))
  Taxasums_Interior$Site_surbers<-as.numeric(Surber_n_Interior$n)
  Taxasums_Interior$Area.m2<-as.numeric((Taxasums_Interior$Site_surbers)*0.09) #Surber size 30*30cm=0.09m2
  Density_Interior<-data.frame((Taxasums_Interior[,-1])/Taxasums_Interior$Area.m2)# Express #indiv/area
  write.csv(Density_Interior, file="output_data/Density_Interior.csv",row.names=FALSE)  

#####################################################
  
  
  
#End of John's requirement: "density per taxa per stream".
#Optional to explore if there's time later: summarize densities by treatment type,round up values, sort by most dense, group by family or by order
  
# 
 