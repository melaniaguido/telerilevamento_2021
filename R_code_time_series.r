#Time series analysis
#Greenland increase of temperature 
#Data and code from Emanuela Cosma 

#install.packages("raster")
library(raster)

setwd("C:/lab/greenland")

#Non abbiamo un unico file, ma ne abbiamo 4 differenti, per cui non possiamo utilizzare la funzione brick
#Ogni strato in questo caso rappresenta la stima della temperatura (lst) che deriva dal programma copernicus 
#andiamo quindi ad importare i singoli dataset 

#Utilizziamo la funzione raster:create a rasterlayer object
lst_2000 <- raster("lst_2000.tif")
plot(lst_2000)
lst_2005 <- raster("lst_2005.tif")
plot(lst_2005)

#Maggiore è il valore del digital number maggiore sarà il valore della temperatura in queste immagini 
lst_2010 <- raster("lst_2010.tif")
plot(lst_2010)
lst_2015 <- raster("lst_2015.tif")
plot(lst_2015)

#par 2x2 
par(mfrow=c(2,2))
plot(lst_2000)
plot(lst_2005)
plot(lst_2010)
plot(lst_2015)

#Utilizziamo un metodo per importare tutte le immagini insieme 
#la funziole "lapply" serve ad applicare una certa funzione ad una lista di file 
#la funzione "list.files" serve a creare la lista di file che r utilizzerà poi per applicare la funzione lapply 
#iniziamo quindi a creare la nostra lista di file
#attraverso "pattern" cerchiamo i files che ci interessano
list.files()
rlist <- list.files(pattern="lst")
rlist 
#abbiamo quindi ottenuto la lista di file a cui applicare la funzione raster 
#lapply applica un'altra funzione ad una lista di file
lapply(rlist, raster) #applichiamo la funzione lapply alla lista di file ottenuta(rlist), e utilizziamo la funzione raster che importa tutti i file 
import <- lapply(rlist, raster) 
import
#Vado ad unire tutti i file importati in un unico file 
TGr <- stack(import) #la funzione stack mi permette di avere un unico file tutto insieme che mi aiuta per esempio a fare direttamente un plot senza utilizzare la funzione par 
plot(TGr)

plot(TGr)
plotRGB(TGr, 1, 2, 3, stretch="Lin")
plotRGB(TGr, 2, 3, 4, stretch="Lin")
plotRGB(TGr, 4, 3, 2, stretch="Lin")

#Day2

library(rasterVis) #il pacchetto rasterVis contiene metodi di visualizzazione per i dati raster 
setwd("C:/lab/greenland")
#importo alcuni dati della scorsa lezione
rlist <- list.files(pattern="lst")
import <- lapply(rlist, raster) 
TGr <- stack(import)

#levelplot è una funzione che mi permette di usare il blocco intero di file, una singola leggenda e facciamo un plot unico 
levelplot(TGr) 

#Cambiamo la palette dei colori 
cl<-colorRampPalette(c("blue","light blue","pink", "red")) (100)
levelplot(TGr,col.regions=cl) #col.regions è l'argomento usato da levelplot per cambiare colore 
#Abbiamo fatto un plot con colori che abbiamo stabilito noi e possiamo vedere multitemporalmente cosa è successo nelle zone che stiamo osservando 

#Andiamo a cambiare il nome agli attributi, names.attr argomento della funzione plot per nominare i sisngoli attributi 
levelplot(TGr,col.regions=cl, names.attr=c("July2000","July2005","July2010","July2015"))
#Inseriamo il titolo della nostra mappa finale attraverso "main"
levelplot(TGr,col.regions=cl, main= "LST variation in time", names.attr=c("July2000","July2005","July2010","July2015"))

#Utilizziamo i dati di Melt 
#Abbiamo molti dati, fare un raster per ognuno sarebbe troppo lungo, per cui facciamo la lista con la funzione list.files
meltlist<-list.files(pattern="melt")
#Applichiamo a questa lista la funzione lapply, e applichiamo la funzione raster 
melt_import<-lapply(meltlist,raster) #Stiamo quindi importando tutti i dati con un'unica funzione
#Facciamo quindi il levelplot di melt 
#Facendo lo stack raggruppo tutti i file appena importati con questa funzione 
melt <- stack(melt_import)
melt 

#facciamo il levelplot
levelplot(melt)

#Andiamo a prendere l'immagine del 1979 e del 2007 e vogliamo fare la sottrazione tra il primo dato e il secondo e a questa sottrazione associare un nome 
#Nella funzione inseriamo il $ che va a legare il file originale allo strato interno 
melt_amount <- melt$X2007annual_melt - melt$X1979annual_melt #Abbiamo fatto la sottrazione tra i due strati

#Visto che è una singola immagine andiamo a fare un plot veloce 
#Creiamo la color palette 
clb <-colorRampPalette(c("blue","white","red")) (100)
plot(melt_amount, col=clb)
#Nell'immagine che otteniamo, tutte le zone rosse sono quelle dove dal 1979 al 2007 c'è stato uno scioglimento del ghiaccio(melt) più alto 
#Otteniamo questo risultato perchè abbiamo sottratto al melt del 2007 quello del 1997

#Andiamo a fare il level plot 
levelplot(melt_amount, col.regions=clb)

#Abbiamo visto come utilizzare un set di dati multitemporali e poter visualizzare tutti i dati insieme con level plot e visualizzare anche la loro differenza 




















