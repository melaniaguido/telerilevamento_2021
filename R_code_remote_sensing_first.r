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

#colour change -> new, impostiamo dei colori a piacere 

cl <- colorRampPalette (c("blue","pink","red","yellow","green")) (100)
plot(p224r63_2011, col=cl)

