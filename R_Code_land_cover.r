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
grid.arrange(p1, p2, nrow=2) #grafici in una pagina 

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
#[1,] 2.930042e-06 0.100351 #10% agricolo
#[2,] 5.860085e-06 0.899649 #89.96% foresta 
#Andiamo a fare la stessa cosa per la seconda mappa 
s2 <- 342726
prop2 <- freq(d2c$map)/s2
#value     count
#[1,] 2.917783e-06 0.5192428 #foresta 51.9%
#[2,] 5.835565e-06 0.4807572 #agricoltura 48.07%

#Andiamo a generare un dataset che in r si chiama dataframe 
cover <- c("Forest","Agriculture") #cover è formata dalle componenti forest e agriculture
percent_1992 <- c(89.96, 10.03) 
percent_2006 <- c(51.92, 48.07)
#data.frame è la funzione che mi permette di creare i dataframe in r
percentages <- data.frame(cover, percent_1992, percent_2006) #Andiamo a definire le colonne 
percentages
#      cover        percent_1992 percent_2006
#1      Forest        89.96        51.92
#2 Agriculture        10.03        48.07

#Andiamo a fare il plot 
#La funzione ggplot e plotta un dataset e poi ha una parte chiamata aestetich, scriviamo la prima e la seconda colonna  e il colore 
#Attraverso geom_bar vado a definire la visualizzazione 
ggplot(percentages, aes(x=cover, y=percent_2006, color=cover)) + geom_bar(stat="identity", fill="white")

#Andiamo a fare il plot di tutte e due utilizzando ggplot 
p1 <- ggplot(percentages, aes(x=cover, y=percent_1992, color=cover)) + geom_bar(stat="identity", fill="white")
p2 <- ggplot(percentages, aes(x=cover, y=percent_2006, color=cover)) + geom_bar(stat="identity", fill="white")
grid.arrange(p1, p2, nrow=1) #Attraverso grid.arrange andiamo a mettere i due grafici vicini nello stessa pagina 




















