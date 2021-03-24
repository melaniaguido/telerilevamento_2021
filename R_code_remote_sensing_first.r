# My first code in R for remote sensing 

#install.packages("raster") per installare un pacchetto in R

library(raster) #questo è per spiegare a R che vogliamo usare il pacchetto raster 

setwd("C:/lab/") #importare in R la cartella desiderata 

#brick è una delle funzioni all'interno del pacchetto raster 
#un raster brick è un oggetto raster multistrato 

p224r63_2011 <- brick("p224r63_2011_masked.grd") #asscoiamo l'immagine importata tramite brick ad un nome 

p224r63_2011 #rasterbrick cioè una serie di bande in formato raster 

plot(p224r63_2011) #Plot è una funzione generica per la stampa di oggetti R 

#colorRampPalette comando con cui siamo noi a stabilire la variazione dei colori 
#per spiegare a R che sono tutti elementi della stessa cosa, vanno racchiusi nello  stesso vettore/array
#inseriamo quindi una c davanti ai colori ed una parentesi che racchiude tutto 

cl <- colorRampPalette (c("black","grey","light grey"))  (100) #100 il numero di livelli che assegno io 

plot(p224r63_2011, col=cl) #primo argomento immagine che vogliamo plottare, secondo argomento il colore che vogliamo dare 

## Day2 

#colour change -> new, impostiamo dei colori a piacere 

cl <- colorRampPalette (c("blue","pink","red","yellow","green")) (100)
plot(p224r63_2011, col=cl)

## Day 3 

#Richiamo il pacchetto raster già creato e poi importo la cartella lab 
library(raster)
setwd("C:/lab/")

#Carico il dataset 

p224r63_2011 <- brick("p224r63_2011_masked.grd")

#plot attraverso la color ramp palet della nostra immagine 

cl <- colorRampPalette (c("blue","pink","red","yellow","green"))  (100)
plot(p224r63_2011, col=cl)

#interrogo l'immagine per avere info su tutte le bande che la compongono 
p224r63_2011

#Bande di landsat 
#B1: banda del blu
#B2: banda del verde
#B3: banda del rosso 
#B4: infrarosso vicino (la prima lunghezza d'onda dopo il rosso)
#B5: infrarosso medio 
#B6: infrarosso termico 
#B7: infrarosso medio 

#ripulisce la finestra grafica così tutte le impostazione partono da zero 
dev.off()

plot(p224r63_2011$B1_sre)
#plot ban 1 con con una scala di colori predefinita dalla color ramp palette 

cl <- colorRampPalette (c("blue","pink","red","yellow","green"))  (100)
plot(p224r63_2011$B1_sre, col=cl)

#facciamo un nuovo plottaggio con due bande di colore una di fianco all'altra 
#utilizzo il comando par per stabilire come voglio fare il plottaggio 
#par serve per mettere tutte le immagini in una stessa finestra, e sistemarle come preferisco
#Se per il primo numero vogliamo indicare le righe mettiamo "mfrow" mentre se vogliamo indicare prima le colonne scriviamo "mfcol"

# 1 riga, 2 colonne
par(mfrow=c(1,2))
plot(p224r63_2011$B1_sre)
plot(p224r63_2011$B2_sre)

#2 righe, 1 colonna 
par(mfrow=c(2,1))
plot(p224r63_2011$B1_sre)
plot(p224r63_2011$B2_sre)

#plot le prime quattro bande di landsat 
par(mfrow=c(4,1))
plot(p224r63_2011$B1_sre)
plot(p224r63_2011$B2_sre)
plot(p224r63_2011$B3_sre)
plot(p224r63_2011$B4_sre)

#2 righe, 2 colonne 
par(mfrow=c(2,2))
plot(p224r63_2011$B1_sre)
plot(p224r63_2011$B2_sre)
plot(p224r63_2011$B3_sre)
plot(p224r63_2011$B4_sre)

#mettiamo per ogni banda una color ramp palette che richiami il colore di quella banda 
par(mfrow=c(2,2))

clb <- colorRampPalette (c("dark blue","blue","light blue"))  (100)
plot(p224r63_2011$B1_sre, col=clb)

clv<- colorRampPalette (c("dark green","green","light green"))  (100)
plot(p224r63_2011$B2_sre, col=clv)

clr<- colorRampPalette (c("dark red","red","pink"))  (100)
plot(p224r63_2011$B3_sre, col=clr)

clnir<- colorRampPalette (c("red","orange","yellow"))  (100)
plot(p224r63_2011$B4_sre, col=clnir)




