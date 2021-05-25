#R_code_variability.r 

#Carichiamo le librerie che ci serviranno 
library(raster)
library(RStoolbox)
library(ggplot2) #per ggplot plotting
library(viridis) #Colorare i plot di ggplot in modo automatico
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
#La prima componente spiega il 67.36% della variabilità originale


#Day2 
#Per misurare la deviazione standard ovvero la variabilità locale all'interno di una mappa utilizziamo la funziona focal 
sentpca$map
#class      : RasterBrick 
#dimensions : 794, 798, 633612, 4  (nrow, ncol, ncell, nlayers)
#resolution : 1, 1  (x, y)
#extent     : 0, 798, 0, 794  (xmin, xmax, ymin, ymax)
#crs        : NA 
#source     : memory
#names      :       PC1,       PC2,       PC3,       PC4 
#min values : -227.1124, -106.4863,  -74.6048,    0.0000 
#max values : 133.48720, 155.87991,  51.56744,   0.00000 

#L'oggetto pc1 verrà d'ora in avanti utilizzato per applicare la funzione focal 
pc1 <- sentpca$map$PC1 
npc15 <- focal (pc1, w=matrix(1/25, nrow=5, ncol=5), fun=sd) #Deviazione standard a 5x5 pixel
cl <- colorRampPalette(c('blue','green','pink','magenta','orange','brown','red','yellow'))(100) # 
plot(npc15, col=cl)

#Per richiamare un pezzo di codice che abbiamo già creato utilizziamo la funzione source
#Utilizziamo la funzione source per richiamare un codice
source("source_ggplot.r")

#Andiamo a plottare tramite ggplot i nostri dati
#ggplot crea una finestra vuota 
#Creare punti dentro ggplot -> geom_point
#Creare delle linee -> geom_line
#geom_raster -> crea la mappa 
ggplot() +
geom_raster(npc15, mapping = aes(x = x, y = y, fill = layer)) + #nome della mappa, inseriamo poi le estetiche, ovvero i valori  
scale_fill_viridis() +
ggtitle ("Standard deviation of PC1 bu viridis colour scale")
# The package contains eight color scales: “viridis”, the primary choice, and five alternatives with similar properties - “magma”, “plasma”, “inferno”, “civids”, “mako”, and “rocket” -, and a rainbow color map - “turbo”. 
#scale_fill_viridis lo utilizziamo per le leggende dei colori 

p1 <- ggplot() +
geom_raster(npc15, mapping = aes(x = x, y = y, fill = layer)) + #nome della mappa, inseriamo poi le estetiche, ovvero i valori  
scale_fill_viridis() +
ggtitle ("Standard deviation of PC1 bu viridis colour scale")

#Metto un'altra leggenda di colore di viridis =magma     
p2 <- ggplot() +
geom_raster(npc15, mapping = aes(x = x, y = y, fill = layer)) +
scale_fill_viridis(option = "magma")  +
ggtitle("Standard deviation of PC1 by magma colour scale")

#Metto un'altra leggenda di colore di viridis = inferno
p3 <- ggplot() +
geom_raster(npc15, mapping = aes(x = x, y = y, fill = layer)) +
scale_fill_viridis(option = "inferno")  +
ggtitle("Standard deviation of PC1 by inferno colour scale")

#Plotto tutte le tre immagini insieme 
grid.arrange(p1, p2, p3, nrow =1)















