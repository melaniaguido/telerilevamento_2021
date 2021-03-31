# My first code in R for remote sensing 

#install.packages("raster") per installare un pacchetto in R

library(raster) #questo è per spiegare a R che vogliamo usare il pacchetto raster 

setwd("C:/lab/") #importare in R la cartella desiderata 

#brick è una delle funzioni all'interno del pacchetto raster 
#un raster brick è un oggetto raster multistrato 

p224r63_2011 <- brick("p224r63_2011_masked.grd") #asscoiamo l'immagine importata tramite brick ad un nome 

p224r63_2011 #rasterbrick cioè una serie di bande in formato raster 

plot(p224r63_2011) #Plot è una funzione generica per la stampa di oggetti R 

#colorRampPalette comando con cui siamo noi a stabilire la variazione dei colori 
#per spiegare a R che sono tutti elementi della stessa cosa, vanno racchiusi nello  stesso vettore/array
#inseriamo quindi una c davanti ai colori ed una parentesi che racchiude tutto 

cl <- colorRampPalette (c("black","grey","light grey"))  (100) #100 il numero di livelli che assegno io 

plot(p224r63_2011, col=cl) #primo argomento immagine che vogliamo plottare, secondo argomento il colore che vogliamo dare 

## Day2 

#colour change -> new, impostiamo dei colori a piacere 

cl <- colorRampPalette (c("blue","pink","red","yellow","green")) (100)
plot(p224r63_2011, col=cl)

## Day 3 

#Richiamo il pacchetto raster già creato e poi importo la cartella lab 
library(raster)
setwd("C:/lab/")

#Carico il dataset 

p224r63_2011 <- brick("p224r63_2011_masked.grd")

#plot attraverso la color ramp palet della nostra immagine 

cl <- colorRampPalette (c("blue","pink","red","yellow","green"))  (100)
plot(p224r63_2011, col=cl)

#interrogo l'immagine per avere info su tutte le bande che la compongono 
p224r63_2011

#Bande di landsat 
#B1: banda del blu
#B2: banda del verde
#B3: banda del rosso 
#B4: infrarosso vicino (la prima lunghezza d'onda dopo il rosso)
#B5: infrarosso medio 
#B6: infrarosso termico 
#B7: infrarosso medio 

#ripulisce la finestra grafica così tutte le impostazione partono da zero 
dev.off()

plot(p224r63_2011$B1_sre)
#plot ban 1 con con una scala di colori predefinita dalla color ramp palette 

cl <- colorRampPalette (c("blue","pink","red","yellow","green"))  (100)
plot(p224r63_2011$B1_sre, col=cl)

#facciamo un nuovo plottaggio con due bande di colore una di fianco all'altra 
#utilizzo il comando par per stabilire come voglio fare il plottaggio 
#par serve per mettere tutte le immagini in una stessa finestra, e sistemarle come preferisco
#Se per il primo numero vogliamo indicare le righe mettiamo "mfrow" mentre se vogliamo indicare prima le colonne scriviamo "mfcol"

# 1 riga, 2 colonne
par(mfrow=c(1,2))
plot(p224r63_2011$B1_sre)
plot(p224r63_2011$B2_sre)

#2 righe, 1 colonna 
par(mfrow=c(2,1))
plot(p224r63_2011$B1_sre)
plot(p224r63_2011$B2_sre)

#plot le prime quattro bande di landsat 
par(mfrow=c(4,1))
plot(p224r63_2011$B1_sre)
plot(p224r63_2011$B2_sre)
plot(p224r63_2011$B3_sre)
plot(p224r63_2011$B4_sre)

#2 righe, 2 colonne 
par(mfrow=c(2,2))
plot(p224r63_2011$B1_sre)
plot(p224r63_2011$B2_sre)
plot(p224r63_2011$B3_sre)
plot(p224r63_2011$B4_sre)

#mettiamo per ogni banda una color ramp palette che richiami il colore di quella banda 
par(mfrow=c(2,2))

clb <- colorRampPalette (c("dark blue","blue","light blue"))  (100)
plot(p224r63_2011$B1_sre, col=clb)

clv<- colorRampPalette (c("dark green","green","light green"))  (100)
plot(p224r63_2011$B2_sre, col=clv)

clr<- colorRampPalette (c("dark red","red","pink"))  (100)
plot(p224r63_2011$B3_sre, col=clr)

clnir<- colorRampPalette (c("red","orange","yellow"))  (100)
plot(p224r63_2011$B4_sre, col=clnir)


#Day 4 Visualizing data by RGB plotting
#Richiamiamo la libreria raster e selezioniamo la nostra cartella di riferimento lab 

library(raster)
setwd("C:/lab/")

#vado a richimare anche la nostra immagine 
p224r63_2011 <- brick("p224r63_2011_masked.grd")

#Bande di landsat 
#B1: banda del blu
#B2: banda del verde
#B3: banda del rosso 
#B4: infrarosso vicino (la prima lunghezza d'onda dopo il rosso)
#B5: infrarosso medio 
#B6: infrarosso termico 
#B7: infrarosso medio

#RGB -> abbiamo tre colori fondamentali (rosso, verde, blu) e in base a come vengono mischiati otteniamo tutti gli altri colori 
#Posso usare solo tre bande per volta per visualizzare l'immagine, nella componente red montiamo la banda n3, nella componente green la banda n2 e nella componente blu la n1
#La funzione che ci permette di fare ciò è la funzione plot, abbiamo un oggetto raster multi-layered(molte bande) e attraverso lo schema RGB andiamo ad utilizzarle 

plotRGB(p224r63_2011, r=3, g=2, b=1, stretch="Lin") #associo ogni singola banda ad un componente dello schema RGB
#stretch -> prendiamo i valori delle singole banda, riflettanza, e li "tiriamo" per far si che non ci sia uno schiacciamento da una parte o dall'altra del colore, quindi vediamo più colori 
#abbiamo ottenuto un'immagine a colori nataruali 

plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="Lin") #L'immagine appare rossa perchè avendo montato la banda dell'infrarosso sulla componente red, tutti gli oggetti con alta riflettanza assumeranno il colore a cui è stata associata la banda n4  
plotRGB(p224r63_2011, r=3, g=4, b=2, stretch="Lin") #Questa volta siccome abbiamo montato la banda dell'infrarosso sulla componente green, tutta la vegetazione appare verde fluorescente (viola suolo nudo) 
plotRGB(p224r63_2011, r=3, g=2, b=4, stretch="Lin") # Qui vediamo il suolo nudo giallo e la vegetazione blu sempre per lo stesso motivo di sopra 

#exercise mount a 2x2 multiframe 
par(mfrow=c(2,2))
plotRGB(p224r63_2011, r=3, g=2, b=1, stretch="Lin")
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="Lin")
plotRGB(p224r63_2011, r=3, g=4, b=2, stretch="Lin")
plotRGB(p224r63_2011, r=3, g=2, b=4, stretch="Lin")

#Per salvare l'immagine in PDF nella cartella di riferimento utilizzo la funzione dedicata pdf()

pdf("il_mio_primo_pdf_con_R.pdf")
par(mfrow=c(2,2))
plotRGB(p224r63_2011, r=3, g=2, b=1, stretch="Lin")
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="Lin")
plotRGB(p224r63_2011, r=3, g=4, b=2, stretch="Lin")
plotRGB(p224r63_2011, r=3, g=2, b=4, stretch="Lin")
Dev.off()

#Plottiamo l'immagine con lo stretch histogram

plotRGB(p224r63_2011, r=3, g=4, b=2, stretch="hist") #Otteniamo un'immagine in cui vediamo molti dettagli che prima non vedevamo 

#Creiamo un par dove abbiamo l'immagine a colori naturali, colori falsati e colori falsati con lo stretch histogram 
par(mfrow=c(3,1))
plotRGB(p224r63_2011, r=3, g=2, b=1, stretch="Lin")
plotRGB(p224r63_2011, r=3, g=4, b=2, stretch="Lin")
plotRGB(p224r63_2011, r=3, g=4, b=2, stretch="hist")

#Siamo quindi partiti da un'immagine esattamente come la vedrebbe l'occhio umano,quindi con pochissima differenziazione 
#E siamo arrivati, tramite lo stretch per istogrammi, ad un'immagine che indivdua tutti i differenti componenti all'interno della foresta 

#A differenza di quando usiamo la funzione color ramp palette in cui siamo noi a scegliere i colori, usando la funzione plotRGB vediamo i colori reali 

#Day5

library(raster)
setwd("C:/lab/")
p224r63_2011 <- brick("p224r63_2011_masked.grd")
p224r63_2011
#la funzione brick importa un intero set di dati creando un blocco di diversi raster insieme 
#Multitemporal set 
#Carico una nuova immagine 
p224r63_1988 <- brick("p224r63_1988_masked.grd") #Associamo il set di dati ad un nome scelto da noi 
#Abbiamo quindi importato un nuovo file 
p224r63_1988 #scriviamo il nome per avere le info sul file 

plot(p224r63_1988) #visualizziamo così le singole bande 

#Bande di landsat 
#B1: banda del blu
#B2: banda del verde
#B3: banda del rosso 
#B4: infrarosso vicino (la prima lunghezza d'onda dopo il rosso)
#B5: infrarosso medio 
#B6: infrarosso termico 
#B7: infrarosso medio
#plotRGB associo ogni singola banda ad un componente dello schema RGB
plotRGB(p224r63_1988, r=3, g=2, b=1, stretch="Lin")

#plottiamo l'immagine usando l'infrarosso e lo associamo alla componente red  
plotRGB(p224r63_1988, r=4, g=3, b=2, stretch="Lin")

#Creiamo uno schema con 2 righe ed 1 colonna inserendo l'immagine del 1988 e del 2011 
par(mfrow=c(2,1))
plotRGB(p224r63_1988, r=4, g=3, b=2, stretch="Lin")
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="Lin")

#Creiamo uno oscema 2x2 con stretch lineare e histogram 
par(mfrow=c(2,2))
plotRGB(p224r63_1988, r=4, g=3, b=2, stretch="Lin")
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="Lin")
plotRGB(p224r63_1988, r=4, g=3, b=2, stretch="hist")
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="hist")

#Creiamo il pdf
pdf("multitemp.pdf")
par(mfrow=c(2,2))
plotRGB(p224r63_1988, r=4, g=3, b=2, stretch="Lin")
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="Lin")
plotRGB(p224r63_1988, r=4, g=3, b=2, stretch="hist")
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="hist")
dev.off()

