#R_code_exam.r
#Analisi manto nevoso della Sierra Nevada nell'arco temporale 2006-2021

#Setto la wd 
setwd("C:/lab/")

#Importo le librerie che mi serviranno 
library(raster)
library(RStoolbox) #Ci serve per la classificazione 
library(ggplot2) 
library(rasterVis) #il pacchetto rasterVis contiene metodi di visualizzazione per i dati raster 
library(viridis) #Colorare i plot di ggplot in modo automatico
library(gridExtra)

#Importo le immagini su cui andrò a lavorare 
nevada1 <- brick("nevada2006.jpg")
nevada2 <- brick ("nevada2021.jpg")
nevada3 <- brick("nevada2010.jpg")
nevada4 <- brick ("nevada2015.jpg")

#Plottiamo le due immagini insieme utilizzando par 
par(mfrow=c(2,1))
plotRGB(nevada1, r=1, g=2, b=3, stretch="Lin")
plotRGB(nevada2, r=1, g=2, b=3, stretch="Lin")

#Time_series 

nevada06 <- raster("nevada2006.jpg")
plot(nevada06)
nevada21 <- raster("nevada2021.jpg")
plot(nevada21)

#Maggiore è il valore del digital number maggiore sarà il valore della temperatura in queste immagini 
nevada10 <- raster("nevada2010.jpg")
plot(nevada10)
nevada15 <- raster("nevada2015.jpg")
plot(nevada15)

par(mfrow=c(2,2))
plot(nevada06)
plot(nevada10)
plot(nevada15)
plot(nevada21)

list.files()
rlist <- list.files(pattern="nevada")
rlist                       #Questo a cosa serve???

#lapply applica un'altra funzione ad una lista di file
lapply(rlist, raster) #applichiamo la funzione lapply alla lista di file ottenuta(rlist), e utilizziamo la funzione raster che importa tutti i file 
import <- lapply(rlist, raster) 
import

[[1]]
class      : RasterLayer 
band       : 1  (of  3  bands)
dimensions : 4352, 4352, 18939904  (nrow, ncol, ncell)
resolution : 1, 1  (x, y)
extent     : 0, 4352, 0, 4352  (xmin, xmax, ymin, ymax)
crs        : NA 
source     : C:/lab/nevada2006.jpg 
names      : nevada2006 
values     : 0, 255  (min, max)


[[2]]
class      : RasterLayer 
band       : 1  (of  3  bands)
dimensions : 4352, 4352, 18939904  (nrow, ncol, ncell)
resolution : 1, 1  (x, y)
extent     : 0, 4352, 0, 4352  (xmin, xmax, ymin, ymax)
crs        : NA 
source     : C:/lab/nevada2010.jpg 
names      : nevada2010 
values     : 0, 255  (min, max)


[[3]]
class      : RasterLayer 
band       : 1  (of  3  bands)
dimensions : 4352, 4352, 18939904  (nrow, ncol, ncell)
resolution : 1, 1  (x, y)
extent     : 0, 4352, 0, 4352  (xmin, xmax, ymin, ymax)
crs        : NA 
source     : C:/lab/nevada2015.jpg 
names      : nevada2015 
values     : 0, 255  (min, max)


[[4]]
class      : RasterLayer 
band       : 1  (of  3  bands)
dimensions : 4352, 4352, 18939904  (nrow, ncol, ncell)
resolution : 1, 1  (x, y)
extent     : 0, 4352, 0, 4352  (xmin, xmax, ymin, ymax)
crs        : NA 
source     : C:/lab/nevada2021.jpg 
names      : nevada2021 
values     : 0, 255  (min, max)

#Vado ad unire tutti i file importati in un unico file 
Nvd <- stack(import) #la funzione stack mi permette di avere un unico file tutto insieme che mi aiuta per esempio a fare direttamente un plot senza utilizzare la funzione par 
plot(Nvd) 

plot(Nvd)
plotRGB(Nvd, 1, 2, 3, stretch="Lin")
plotRGB(Nvd, 2, 3, 4, stretch="Lin")
plotRGB(Nvd, 4, 3, 2, stretch="Lin")    #Immagine con colori particolari 

#levelplot è una funzione che mi permette di usare il blocco intero di file, una singola leggenda e facciamo un plot unico 
levelplot(Nvd) 

#Cambiamo la palette dei colori 
cl<-colorRampPalette(c("blue","light blue","pink", "red")) (100)
levelplot(Nvd,col.regions=cl) #col.regions è l'argomento usato da levelplot per cambiare colore 
#Abbiamo fatto un plot con colori che abbiamo stabilito noi e possiamo vedere multitemporalmente cosa è successo nelle zone che stiamo osservando 

#Andiamo a cambiare il nome agli attributi, names.attr argomento della funzione plot per nominare i sisngoli attributi 
#Inseriamo il titolo della nostra mappa finale attraverso "main"
levelplot(Nvd,col.regions=cl, main= "Snowpack variation in time", names.attr=c("April2006","April2010","April2015","April2021"))


library(gridExtra)
#Vado a fare il plot delle due immagine utilizzando ggRGB
p1 <- ggRGB(nevada1, r=1, g=2, b=3, stretch="lin")
p2 <- ggRGB(nevada2, r=1, g=2, b=3, stretch="lin")
grid.arrange(p1, p2, nrow=2) #grafici in una pagina

#Classificazione non supervisionata 
d1c3 <- unsuperClass(nevada1, nClasses=3)
#Facciamo il plot 
plot(d1c3$map)
#Modifichiamo la palette colori 
cl <- colorRampPalette(c('light blue','pink', 'white'))(100) 
plot(d1c3$map, col=cl)


d2c3 <- unsuperClass(nevada2, nClasses=3)
plot(d2c3$map, col=cl)

par(mfrow=c(2,1))
plot(d1c3$map, col=cl)
plot(d2c3$map, col=cl)

#pixel di ciascuna classe 
 freq(d1c3$map)
  # value   count
#[1,]     1 6460829
#[2,]     2 8015537
#[3,]     3 4463538

s1 <-  6460829 + 8015537 + 4463538 #Somma di tutti i pixel

prop1 <- freq(d1c3$map)/s1 #Otteniamo così le proporzioni

#value cont 
#[1,] 5.279858e-08 0.3411226    34%
#[2,] 1.055972e-07 0.4232090    42%
#[3,] 1.583957e-07 0.2356685    24%

#seconda immagine 
freq(d2c3$map)
    #value   count
#[1,]     1 6995286
#[2,]     2 4763875
#[3,]     3 7180743
s2 <- 6995286 +  4763875 + 7180743
prop2 <- freq(d2c3$map)/s2
prop2
 
  #value     count
#[1,] 5.279858e-08 0.3693412     37%
#[2,] 1.055972e-07 0.2515258     25%
#[3,] 1.583957e-07 0.3791330     38%

#Andiamo a generare un dataset che in r si chiama dataframe 
cover <- c("grass","snow", "soil") #cover è formata dalle componenti grass, snow e soil 
percent_2006 <- c(34.11, 42.32, 23.56) 
percent_2021 <- c(36.93, 25.15, 37.91)
#data.frame è la funzione che mi permette di creare i dataframe in r
percentages <- data.frame(cover, percent_2006, percent_2021) #Andiamo a definire le colonne 
percentages

#cover percent_2006 percent_2021
#1 grass        34.11        36.93
#2  snow        42.32        25.15
#3  soil        23.56        37.91


#Andiamo a fare il plot 
#La funzione ggplot e plotta un dataset e poi ha una parte chiamata aestetich, scriviamo la prima e la seconda colonna  e il colore 
#Attraverso geom_bar vado a definire la visualizzazione 
#Andiamo a fare il plot di tutte e due utilizzando ggplot 
p1 <- ggplot(percentages, aes(x=cover, y=percent_2006, color=cover)) + geom_bar(stat="identity", fill="white")
p2 <- ggplot(percentages, aes(x=cover, y=percent_2021, color=cover)) + geom_bar(stat="identity", fill="white")
grid.arrange(p1, p2, nrow=1) #Attraverso grid.arrange andiamo a mettere i due grafici vicini nello stessa pagina 


















