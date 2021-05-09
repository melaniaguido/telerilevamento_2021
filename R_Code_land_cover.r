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
# names: defor1.1, defor1.2, defor1.3 
# defor1.1 = NIR
# defor1.2 = red
# defor1.3 = green

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

#Classificazione non supervisionata 
d1c <- unsuperClass(defor1, nClasses=2)
#Facciamo il plot 
plot(d1c$map)
#Modifichiamo la palette colori 
cl <- colorRampPalette(c('black','green'))(100) 
plot(d1c$map, col=cl)

#classificare con due classi l'immagine satellitare defor2
d2c <- unsuperClass(defor2, nClasses=2)
plot(d2c$map, col=cl)

# plot delle due mappe ottenute
par(mfrow=c(2,1))
plot(d1c$map, col=cl)
plot(d2c$map, col=cl)

par(mfrow=c(1,2))
plot(d1c$map, col=cl)
plot(d2c$map, col=cl)

#Proviamo a fare una classificazione con 3 classi 
d2c3 <- unsuperClass(defor2, nClasses=3)
plot(d2c3$map)

#Vogliamo clacolare la frequenza dei pixel di una certa classe, quante volte ho determinati pixel di una certa classe 
#Utilizziamo la funzione freq che va a calcolare la frequenza 
freq(d1c$map) #In questo caso vogliamo sapere la frequenza delle due classi nella mappa che abbiamo generato 
#I valori ottenuti sono :  
#value  count
#[1,]     1  34249
#[2,]     2 307043
s1 <- 34249 + 307043 #Somma di tutti i pixel 
#Qual è la frequenza dei pixel di foresta? 
prop1 <- freq(d1c$map)/s1 #Otteniamo così le proporzioni 
# value    count
#[1,] 2.930042e-06 0.100351
#[2,] 5.860085e-06 0.899649




















