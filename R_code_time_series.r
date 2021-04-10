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



