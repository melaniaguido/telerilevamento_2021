#R_code_exam.r
#Analisi manto nevoso della Sierra Nevada nell'arco temporale 2006-2021

#Setto la wd 
setwd("C:/lab/")

#Importo le librerie che mi serviranno 
library(raster) #questo è per spiegare a R che vogliamo usare il pacchetto raster 
library(RStoolbox) #Ci serve per la classificazione 
library(ggplot2) #Serve per creare i grafici 
library(rasterVis) #il pacchetto rasterVis contiene metodi di visualizzazione per i dati raster 
library(viridis) #Colorare i plot di ggplot in modo automatico


#Importo le immagini su cui andrò a lavorare utilizzando la funzione brick che mi permette di importare un oggetto raster multistrato 
#Associamo ad ogni immagine importata tramite brick ad un nome
nevada1 <- brick("nevada2006.jpg")
nevada2 <- brick("nevada2010.jpg")
nevada3 <- brick ("nevada2015.jpg")
nevada4 <- brick ("nevada2021.jpg")


#Vado a fare il plot delle immagini utilizzando ggRGB
#Abbiamo un'immagine con 3 bande, e possiamo creare un'immagine singola delle 3 bande usando ggRGB, quindi partendo da tre bande dell'immagine satellitare, possiamo unirle per creare un immagine a banda singola
#Per fare il plot abbiamo bisogno dell'immagine da plottare, delle 3 componenti RGB 
p1 <- ggRGB(nevada1, r=1, g=2, b=3, stretch="lin")
p2 <- ggRGB(nevada2, r=1, g=2, b=3, stretch="lin")
p3 <- ggRGB(nevada3, r=1, g=2, b=3, stretch="lin")
p4 <- ggRGB(nevada4, r=1, g=2, b=3, stretch="lin")
grid.arrange(p1, p2, p3, p4,  nrow=2)  #Attraverso grid.arrange andiamo a mettere i due grafici vicini nello stessa pagina 

#Time_series 
#Analizziamo l'immagine nel tempo, in modo da vedere come questa varia negli anni
#Utilizziamo la funzione raster:create a rasterlayer object
nevada06 <- raster("nevada2006.jpg")
plot(nevada06)
nevada21 <- raster("nevada2021.jpg")
plot(nevada21)
nevada10 <- raster("nevada2010.jpg")
plot(nevada10)
nevada15 <- raster("nevada2015.jpg")
plot(nevada15)

#Faccio il plot delle immagini e utilizzo la funzione par che serve per mettere tutte le immagini in una stessa finestra, e sistemarle come preferisco
par(mfrow=c(2,2))
plot(nevada06)
plot(nevada10)
plot(nevada15)
plot(nevada21)

# per evitare di importare singolarmente i files, creo una lista dei files di interesse e li associo ad un oggetto (rlist) per facilitare le funzioni successive 
#voglio importare i file tutti insieme invece di usare raster e importarli uno per volta, uso quindi lapply
#lapply: applicare una funzione ad una lista di file (rlist)
#la list.files: crea la lista che R utilizzerà per applicare la funzione lapply
#con pattern ricerchiamo i file che ci servono in base alle caratteristiche comuni nel nome
rlist <- list.files(pattern="nevada")
rlist            
#[1] "nevada2006.jpg" "nevada2010.jpg" "nevada2015.jpg" "nevada2021.jpg"
#applichiamo la funzione lapply alla lista di file ottenuta(rlist), e utilizziamo la funzione raster che importa tutti i file 
import <- lapply(rlist, raster) 
import

#[[1]]
#class      : RasterLayer 
#band       : 1  (of  3  bands)
#dimensions : 4352, 4352, 18939904  (nrow, ncol, ncell)
#resolution : 1, 1  (x, y)
#extent     : 0, 4352, 0, 4352  (xmin, xmax, ymin, ymax)
#crs        : NA 
#source     : C:/lab/nevada2006.jpg 
#names      : nevada2006 
#values     : 0, 255  (min, max)


#[[2]]
#class      : RasterLayer 
#band       : 1  (of  3  bands)
#dimensions : 4352, 4352, 18939904  (nrow, ncol, ncell)
#resolution : 1, 1  (x, y)
#extent     : 0, 4352, 0, 4352  (xmin, xmax, ymin, ymax)
#crs        : NA 
#source     : C:/lab/nevada2010.jpg 
#names      : nevada2010 
#values     : 0, 255  (min, max)


#[[3]]
#class      : RasterLayer 
#band       : 1  (of  3  bands)
#dimensions : 4352, 4352, 18939904  (nrow, ncol, ncell)
#resolution : 1, 1  (x, y)
#extent     : 0, 4352, 0, 4352  (xmin, xmax, ymin, ymax)
#crs        : NA 
#source     : C:/lab/nevada2015.jpg 
#names      : nevada2015 
#values     : 0, 255  (min, max)


#[[4]]
#class      : RasterLayer 
#band       : 1  (of  3  bands)
#dimensions : 4352, 4352, 18939904  (nrow, ncol, ncell)
#resolution : 1, 1  (x, y)
#extent     : 0, 4352, 0, 4352  (xmin, xmax, ymin, ymax)
#crs        : NA 
#source     : C:/lab/nevada2021.jpg 
#names      : nevada2021 
#values     : 0, 255  (min, max)

#Vado ad unire tutti i file importati in un unico file 
#Possiamo creare un unico pacchetto di file con tutti quelli importati, lo facciamo con la funzione stack
#stack function: abbiamo una lista di file raster e li mettiamo tutti insieme
Nvd <- stack(import) #la funzione stack mi permette di avere un unico file tutto insieme che mi aiuta per esempio a fare direttamente un plot senza utilizzare la funzione par 
plot(Nvd) 

#Cambiamo la palette dei colori 
cl<-colorRampPalette(c("blue","yellow","green", "red")) (100)

#levelplot è una funzione che mi permette di usare il blocco intero di file, una singola leggenda e facciamo un plot unico
levelplot(Nvd,col.regions=cl, main= "Snowpack variation in time", names.attr=c("April2006","April2010","April2015","April2021"))
#col.regions è l'argomento usato da levelplot per cambiare colore 
#Abbiamo fatto un plot con colori che abbiamo stabilito noi e possiamo vedere multitemporalmente cosa è successo nelle zone che stiamo osservando 
#Andiamo a cambiare il nome agli attributi, names.attr argomento della funzione plot per nominare i sisngoli attributi 
#Inseriamo il titolo della nostra mappa finale attraverso "main"


#Land cover 
#analisi multitemporale di variazione della land cover
par(mfrow=c(1,2))
plotRGB(nevada1, 1,2,3, stretch="hist")
plotRGB(nevada3, 1,2,3, stretch="hist")
#Per l'analisi della land cover utilizzo solo l'immagine nevada1 e nevada3 

#Classifichiamo l'immagine
#La funzione è unsuperClass (Unsupervided classification) 
#All'interno del pacchetto Rstoolbox opera la classificazione non supervisionata
#Serve per la classificazione dei pixel in classi 
#unsuperClass mi permette di discriminare i pixel delle immagini dividendoli in classi in base alla riflettanza
set.seed(1) #Attrraverso queste funzioni blocco le classi in modo che in tutte e due le immagini avrò le stesse classi associate agli stessi colori 
rnorm(1)
d1c3 <- unsuperClass(nevada1, nClasses=3)
#Modifichiamo la palette colori e facciamo il plot 
cl <- colorRampPalette(c('light blue','pink', 'white'))(100) 
plot(d1c3$map, col=cl)

#Facciamo la stessa cosa per la seconda immagine 
set.seed(1)
rnorm(1)
d2c3 <- unsuperClass(nevada3, nClasses=3)
plot(d2c3$map, col=cl)

#Vado a fare il plot delle immagini appena classificate 
par(mfrow=c(1,2))
plot(d1c3$map, col=cl)
plot(d2c3$map, col=cl)


##calcoliamo ora la frequenza dei pixel di una certa classe nelle mappe generate
#nevada1
 freq(d1c3$map)
  # value   count
#[1,]     1 6460829
#[2,]     2 8015537
#[3,]     3 4463538

s1 <-  6460829 + 8015537 + 4463538 #Somma di tutti i pixel

prop1 <- freq(d1c3$map)/s1 #Otteniamo così le proporzioni
prop1
#value cont 
#[1,] 5.279858e-08 0.3411226    34%
#[2,] 1.055972e-07 0.4232090    42%
#[3,] 1.583957e-07 0.2356685    24%

#Andiamo a fare la stessa cosa per la seconda immagine
#nevada3 
freq(d2c3$map)
    #value   count
#[1,]     1 7813028
#[2,]     2 5366960
#[3,]     3 5759916

s2 <- 7813028 +  5366960 + 5759916
prop2 <- freq(d2c3$map)/s2
prop2
 
          #value     count
#[1,] 5.279858e-08 0.4125168   41%
#[2,] 1.055972e-07 0.2833679   28%
#[3,] 1.583957e-07 0.3041154   31%

#Andiamo a generare un dataset che in r si chiama dataframe 
cover <- c("grass","snow", "soil") #cover è formata dalle componenti grass, snow e soil 
percent_2006 <- c(34.11, 42.32, 23.56) 
percent_2015 <- c(41.25, 28.33, 30.41)
#data.frame è la funzione che mi permette di creare i dataframe in r
percentages <- data.frame(cover, percent_2006, percent_2015) #Andiamo a definire le colonne 
percentages

  #cover percent_2006 percent_2015
#1 grass        34.11        41.25
#2  snow        42.32        28.33
#3  soil        23.56        30.41


#Andiamo a fare il plot di tutte e due utilizzando ggplot 
#La funzione ggplot plotta un dataset e poi ha una parte chiamata aestetich, scriviamo la prima e la seconda colonna  e il colore 
#Attraverso geom_bar vado a definire la visualizzazione 
p1 <- ggplot(percentages, aes(x=cover, y=percent_2006, color=cover)) + geom_bar(stat="identity", fill="white")
p2 <- ggplot(percentages, aes(x=cover, y=percent_2015, color=cover)) + geom_bar(stat="identity", fill="white")
grid.arrange(p1, p2, nrow=1) 
#Attraverso grid.arrange andiamo a mettere i due grafici vicini nello stessa pagina 








