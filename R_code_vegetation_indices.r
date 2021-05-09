#R_code_vegetation_indices.r 

library(raster) #Carichiamo la libreria che ci serve 
setwd("C:/lab/") #Settiamo la wd

#Utilizziamo la funzione brick per caricare un set di dati 
#In questo caso andiamo a caricare le immagini che ci interessano
defor1 <- brick("defor1.jpg")
defor2 <- brick("defor2.jpg")

#Andiamo a fare il plot delle due immagini 
par(mfrow=c(2,1))
#b1=NIR, b2=red, b3=green
plotRGB(defor1, r=1, g=2, b=3, stretch="lin")
plotRGB(defor2, r=1, g=2, b=3, stretch="lin")

#Andiamo a calcolare l'indice di vegetazione sia per l'immagine più datata che per quella più recente 
#Digitiamo in r il nome del file originario per vedere come si chiamano le bande del NIR e del red che ci serviranno per l'indice 
defor1 #In questo caso il NIR si chiama defor1.1 e il red si chiama defor1.2 
#Dichiariamo il nome del dataset e il nome della banda uniti tramite $
dvi1 <- defor1$defor1.1 - defor1$defor1.2 #il meno è un'operazione algebrica 
#Per ogni pixel stiamo prendendo la banda dell'infrarosso e quella del rosso, e facciamo la sottrazione per i due valori del pixel
#In uscita abbiamo una mappa formata da tanti pixel che sono la diferenza tra NIR e red e quindi il DVI 

#Viasualizziamo la mappa 
plot(dvi1) #quest'immagine rappresenta molto bene lo stato di salute della vegetazione 
#Facciamo una nuova visualizzazione cambiano la color ramp palette 
cl <- colorRampPalette(c('darkblue','yellow','red','black'))(100) # specifying a color scheme
plot(dvi1, col=cl, main="DVI at time 1") 

#Facciamo la stessa cosa per la seconda immagine 
defor2 #Per visualizzare il nome del NIR e red 
dvi2 <- defor2$defor2.1 - defor2$defor2.2 
#Visualizziamo la mappa 
plot(dvi2)
#Cambiamo la palette 
cl <- colorRampPalette(c('darkblue','yellow','red','black'))(100)
plot(dvi2, col=cl, main="DVI at time 2")

#Facciamo il plot delle due immagiini insieme così da fare un confronto 
par(mfrow=c(2,1))
plot(dvi1, col=cl, main="DVI at time 1")
plot(dvi2, col=cl, main="DVI at time 2")

#Generiamo una mappa dove avremo la differenza tra il DVI della prima immagine e il DVI della seconda 
difdvi <- dvi1 - dvi2 
#Facciamo il plot 
cld <- colorRampPalette(c('blue','white','red'))(100)
plot(difdvi, col=cld) #Questa mappa ci permette di vedere quali sono i punti all'interno dell'area dove c'è stata una sofferenza da parte nella vegetazione nel tempo 

#Calcoliamo l'NDVI (normalizza i nostri valori sulla somma delle variabili)
# (NIR-RED) / (NIR+RED)
ndvi1 <- (defor1$defor1.1 - defor1$defor1.2) / (defor1$defor1.1 + defor1$defor1.2)
#Facciamo il plot 
plot(ndvi1, col=cl) 

#Facciamo la stessa cosa per la seconda immagine 
ndvi2 <- (defor2$defor2.1 - defor2$defor2.2) / (defor2$defor2.1 + defor2$defor2.2)
#Facciamo il plot 
plot(ndvi2, col=cl)

#Andiamo a fare la differenza tra i due NDVI
difndvi <- ndvi1 - ndvi2
plot(difndvi, col=cld)

#Richiamiamo il pacchetto Rstoolbox che ci servirà per le prossime funzioni 
library(RStoolbox) #In questo caso ci servirà per il calcolo degli indici di vegetazione 

#La funzione che utilizziamo è spectralIndices che calcola diversi indici e permette di visualizzarli insieme 
#Facciamolo per la prima immagine
vi1 <- spectralIndices(defor1, green = 3, red = 2, nir = 1)
plot(vi1, col=cl)
#Facciamo la stessa cosa per la seconda immagine
vi2 <- spectralIndices(defor2, green = 3, red = 2, nir = 1)
plot(vi2, col=cl)

#Andiamo a riclassificare l'immagine originale copNDVI
#cbind è argomento a funzione, e cambia dei valori 
#I pixel con valori 253, 254 e 255 (acqua) possono essere trasformati in NA(non valori) 
copNDVI <- reclassify(copNDVI, cbind(253:255, NA))
plot(copNDVI)

#Richiamiamo il pacchetto rasterVis per utilizzare la funzione levelplot
library(rasterVis)
levelplot(copNDVI) 

















