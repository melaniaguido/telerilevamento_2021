#R_code_multivariate_analysis.r

#Carichiamo i pacchetti 
library(raster)
library(RStoolbox)

#Settiamo la wd 
setwd("C:/lab/") 

#Carichiamo l'immagine 
#Questa immagine ha 7 bande, per caricarla utilizziamo la funzione brick che serve a caricare un set multiplo di dati 
p224r63_2011 <-brick("p224r63_2011_masked.grd")
p224r63_2011 #Visualizziamo le informazioni 
#visualizziamola
plot(p224r63_2011)#Ovviamente avremo 7 immagini, una per ogni banda 

#Plottiamo i valori della banda del blu contro i valori della banda del verde 
plot(p224r63_2011$B1_sre, p224r63_2011$B2_sre, col="red", pch=25, cex=2) #pch cambiamo i simboli, cex cambiamo la dimensione

#La funzione pairs serve per plottare tutte le correlazioni possibili in tutti i dataset 
#Mette in correlazioni a due a due tutte le variabili di un certo dataset 
#In questo caso le nostre variabili sono le bande
pairs(p224r63_2011) #Sulla parte alta troveremo l'indice di correlazione, se si è positivamente correlati l'indice va ad uno, al contrario va a -1

