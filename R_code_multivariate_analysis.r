#R_code_multivariate_analysis.r

#Carichiamo i pacchetti 
library(raster)
library(RStoolbox)

#Settiamo la wd 
setwd("C:/lab/") 

#Carichiamo l'immagine 
#Questa immagine ha 7 bande, per caricarla utilizziamo la funzione brick che serve a caricare un set multiplo di dati 
p224r63_2011 <-brick("p224r63_2011_masked.grd")
p224r63_2011 #Visualizziamo le informazioni 
#visualizziamola
plot(p224r63_2011)#Ovviamente avremo 7 immagini, una per ogni banda 

#Plottiamo i valori della banda del blu contro i valori della banda del verde 
plot(p224r63_2011$B1_sre, p224r63_2011$B2_sre, col="red", pch=25, cex=2) #pch cambiamo i simboli, cex cambiamo la dimensione

#La funzione pairs serve per plottare tutte le correlazioni possibili in tutti i dataset 
#Mette in correlazioni a due a due tutte le variabili di un certo dataset 
#In questo caso le nostre variabili sono le bande
pairs(p224r63_2011) #Sulla parte alta troveremo l'indice di correlazione, se si è positivamente correlati l'indice va ad uno, al contrario va a -1



#Day2 
#Carichiamo i pacchetti 
library(raster)
library(RStoolbox)

#Settiamo la wd, selezioniamo la cartella di riferimento 
setwd("C:/lab/")
#Carichiamo l'immagine da utilizzare 
p224r63_2011 <-brick("p224r63_2011_masked.grd")

#attraverso la funzione pairs otteniamo i grafici che ci mostrano la relazione tra le bande 
pairs(p224r63_2011)

#La PCA è un'analisi impattante quindi un'idea sarebbe ricampionare il nostro dato, crearne quindi uno più leggero 
#Attraverso la funzione aggregate andiamo ad aggregare i pixel ottenendo una risoluzione più bassa 
#res= resampling -> ricampionamento 
p224r63_2011res <- aggregate(p224r63_2011, fact=10) #Fact è il fattore di ricampionamento, quante volte vogliamo ingradire i pixel 

#per vedere il risultato facciamo un plot mettendo insieme l'immagine originale e  quella ricampionata 
par(mfrow=c(2,1))
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="lin")
plotRGB(p224r63_2011res, r=4, g=3, b=2, stretch="lin")
 
#La PCA Esegue l'analisi dei componenti principali (PCA) con individui supplementari, variabili quantitative supplementari e variabili categoriali supplementari. I valori mancanti vengono sostituiti dalla media della colonna.
#La rasterPCA prende il pacchetto di dati e va a compattarli in un numero minore di bande 
p224r63_2011res_pca <- rasterPCA(p224r63_2011res)

#Andiamo a legare attraverso $ due componenti 
#In questo caso leghiamo l'immagine al modello
summary(p224r63_2011res_pca$model) #summary è una funzione generica, in questo caso ci da un sommario del nostro modello 

#Visualizziamo le varie componenti 
#Leghiamo l'immagine a map perchè andiamo ad unire l'immagine con la mappa del modello 
#Qui stiamo plottando la mappa risultante dal modello di prima 
plot(p224r63_2011res_pca$map) #La prima componente sarà quella migliore, dove si vede tutto, nell'ultima non si distingue praticamente nulla
#Questo perchè la componente uno è quella che spiega più variabilità

#Facciamo  un plot con le 3 componenti principali 
plotRGB(p224r63_2011res_pca$map, r=1, g=2, b=3, stretch="lin")
























