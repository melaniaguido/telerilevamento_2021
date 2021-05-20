#R_code_variability.r 

#Carichiamo le librerie che ci serviranno 
library(raster)
library(RStoolbox)
library(ggplot2)
library(viridis)
library(gridExtra)

#settiamo la wd 
setwd("C:/lab/")

#Importiamo l'immagine 
sentinel <- brick("sentinel.png")
sentinel
#NIR1, RED2, GREEN3
#r=1, g=2, b=3 siccome questa è esattamente la composizione di default possiamo anche evitare di scriverle 
plotRGB(sentinel) #Visualizziamo l'immagine, utilizzando la funzione plotRGB essendo la nostra immagine a tre componenti
#Se cambiamo la posizione delle bande allora diventa 
plotRGB(sentinel, r=2, g=1, b=3, stretch="lin")

#Per fare il calcolo della deviazione standard possiamo utilizzare una sola banda 
sentinel_pca <- rasterPCA(sentinel)

sentinel
#class      : RasterBrick 
#dimensions : 794, 798, 633612, 4  (nrow, ncol, ncell, nlayers)
#resolution : 1, 1  (x, y)
#extent     : 0, 798, 0, 794  (xmin, xmax, ymin, ymax)
#crs        : NA 
#source     : C:/lab/sentinel.png 
#names      : sentinel.1, sentinel.2, sentinel.3, sentinel.4 
#min values :          0,          0,          0,          0 
#max values :        255,        255,        255,        255 

#Associamo l'immagine con la banda del NIR
nir <- sentinel$sentinel.1
#Associamo l'immagine con la banda del red 
red <- sentinel$sentinel.2
#Ora ci calcoliamo NDVI
ndvi <- (nir-red)/(nir+red)
#Visualizziamo l'immagine 
plot(ndvi)
#Cambiamo la color palette 
cl <- colorRampPalette(c('black','white','red','magenta','green'))(100) # 
plot(ndvi,col=cl)

#Calcoliamo la deviazione standard dell'immagine, cioè la variabilità della nostra immagine
#Utilizziamo la funzione focal 
#Calcola i valori focali per le celle focali vicine utilizzando una matrice di pesi, magari in combinazione con una funzione.
#Funzione focal, del davo appena creato ndvi
#Altro argomento a funzione è w che è una matrice di numeri, nel nostro caso una finestra spaziale. Scriviamo le righe e le colonne della nostra matrice 
#Noi consideriamo 9 pixel, 3 righe e 3 colonne per la nostra matrice 
#fun=sd indica che stiamo calcolando la deviazione standard 
ndvisd3 <- focal(ndvi, w=matrix(1/9,nrow=3,ncol=3), fun=sd)
#Fatto ciò possiamo fare il plot della nostra sd 
plot(ndvisd3)
#Cambiamo la color ramp palette e facciamo il plot 
colorRampPalette(c('blue','green','pink','magenta','orange','brown','red','yellow'))(100) # 
plot(ndvisd3, col=clsd)

#Calcoliamo la media della deviazione standard 
ndvimean3 <- focal(ndvi, w=matrix(1/9,nrow=3,ncol=3), fun=mean)
#Facciamo il plottaggio con la stessa palette di prima 
colorRampPalette(c('blue','green','pink','magenta','orange','brown','red','yellow'))(100) # 
plot(ndvimean3, col=clsd)

#Facciamo la deviazione standard per 13pixel 
ndvisd13 <- focal(ndvi, w=matrix(1/169,nrow=13,ncol=13), fun=sd)
colorRampPalette(c('blue','green','pink','magenta','orange','brown','red','yellow'))(100) # 
plot(ndvisd13, col=clsd)

#Andiamo a dare un nome al nostro modello PCA
sentpca <- rasterPCA(sentinel)
#Facciamo il plot 
plot(sentpca$map) #La prima componente principale mantiene la % di info più alta è molto simile all'info originale 
#Man mano che passiamo da una PC all'altra l'informazione va a perdersi 

#Abbiamo quindi fatto l'analisi multivariata della nostra immagine 

summary(sentpca$model) 
#Importance of components:
                         #  Comp.1     Comp.2      Comp.3 Comp.4
#Standard deviation     77.3362848 53.5145531 5.765599616      0
#Proportion of Variance  0.6736804  0.3225753 0.003744348      0
#Cumulative Proportion   0.6736804  0.9962557 1.000000000      1
#La prima componente spiega il 77.3362848% della variabilità originale

























