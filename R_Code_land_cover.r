#R_Code_land_cover.r 
#analisi multitemporale di variazione della land cover

#Setto la wd 
setwd("C:/lab/")

#Importo le librerie che mi serviranno 
library(raster)
library(RStoolbox) #Ci serve per la classificazione 
library(ggplot2) 

#Importo le immagini su cui andremo a lavorare 
defor1 <- brick("defor1.jpg") 
defor2 <- brick("defor2.jpg")

defor1
# names: defor1_.1, defor1_.2, defor1_.3 
# defor1_.1 = NIR
# defor1_.2 = red
# defor1_.3 = green

#Plottiamo le due immagini 
plotRGB(defor1, r=1, g=2, b=3, stretch="Lin")
plotRGB(defor2, r=1, g=2, b=3, stretch="Lin")

#Abbiamo un'immagine con 3 bande, e possiamo creare un'immagine singola delle 3 bande usando ggRGB
#Abbiamo bisogno dell'immagine da plottare, delle 3 componenti RGB e possiamo utilizzare anche qui lo stretch
ggRGB(defor2, r=1, g=2, b=3, stretch="lin")
ggRGB(defor1, r=1, g=2, b=3, stretch="lin")

#Plottiamo le due immagini insieme 
par(mfrow=c(2,1))
plotRGB(defor1, r=1, g=2, b=3, stretch="Lin")
plotRGB(defor2, r=1, g=2, b=3, stretch="Lin")

#La funzione dedicata a ggplot per ottenere lo stesso risultato ottenuto con par è grid.arrange
#Vado a richiamare la libreria dedicata per utilizzare questa funzione
library(gridExtra)
#Vado a fare il plot delle due immagine utilizzando ggRGB
p1 <- ggRGB(defor1, r=1, g=2, b=3, stretch="lin")
p2 <- ggRGB(defor2, r=1, g=2, b=3, stretch="lin")
grid.arrange(p1, p2, nrow=2)

























