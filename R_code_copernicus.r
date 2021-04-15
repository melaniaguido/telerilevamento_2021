#R_code_copernicus.r
#Prepariamo il nostro codice per i dati copernicus 

#Le librerie che ci serviranno sono la raster e la ncdf4 che ci serve per leggere il formato dei dati che abbiamo scaricato da copernicus 
library(raster)
install.packages("ncdf4")
library(ncdf4)
setwd("C:/lab/")

#dobbiamo scegliere il nome da dare al nostro dataset, utilizzo FCOVER
#utilizziamo raster perchè  è un singolo file, se erano di più avremmo utilizzato brick
FCOVER <- raster ("c_gls_FCOVER-RT0_202006300000_GLOBE_PROBAV_V2.0.1.nc")

#possiamo fare ora il primo plot
#siccome non usiamo uno schema RGB, possiamo decidere noi la color ramp 

cl <- colorRampPalette(c('light blue','green','red','yellow'))(100)
plot(FCOVER, col=cl)

#Andiamo a ricampionare il file, a ridurre quindi la risoluzione in modo che sia più gestibile 
#Per alleggerire l'immagine prendo un pixel più grande e all'interno del pixel estraggo la media di tutti i valori al suo interno 
#Trasformo quindi l'immagine con un numero inferiore di pixel 
#Per fare  ciò possiamo utilizzare fact, nel mio caso fact=100 diminuisco linearmente di 100 volte 
FCOVERres <- aggregate(FCOVER, fact=100)
#a questo punto facendo un plot, si può vedere come la variabile è molto più veloce da visualizzare perchè i pixel al suo interno sono più grandi 


 
