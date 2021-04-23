#R_code_classification.r

#Settiamo la nostra wd 
setwd("C:/lab/")
library(raster)
library(RStoolbox)

#Carichiamo l'immagine 
#L'immagine rappresenta i diversi livelli di energia del sole nella parte interessata 
so <- brick("Solar_Orbiter_s_first_views_of_the_Sun_pillars.jpg") 
#La funzione brick permette di prendere un'immagine dall'esterno di r 
#Immagine RGB con diversi livelli 
so

#Facciamo il plottaggio 
#inseriamo il nome dell'immagine,i 3 livelli e infine lo stretch
plotRGB(so, 1,2,3, stretch="lin")

#Classifichiamo l'immagine 
#La funzione è unsuperClass (Unsupervided classification) 
#All'interno del pacchetto Rstoolbox opera la classificazione non supervisionata
soc <- unsuperClass(so, nClasses=3) #Nella funzione inseriamo il nome dell'immagine e il numero di classi 
#Una volta fatta la classificazione (abbiamo creato un modello di classificazione), possiamo fare il plot dell'immagine 
plot(soc$map)
#Utilizziamo una funzione che fa in modo che esca la stessa classificazione per tutti 
#Per fare ciò utilizziamo la funzione set.seed
set.seed(42)

#Aumentiamo il numero delle classi per vedere cosa vede il software
socl <- unsuperClass(so, nClasses=20)
plot(socl$map)

#Day 2 

#Grand Canyon 
#https://landsat.visibleearth.nasa.gov/view.php?id=80948
# When John Wesley Powell led an expedition down the Colorado River and through the Grand Canyon in 1869, he was confronted with a daunting landscape. At its highest point, the serpentine gorge plunged 1,829 meters (6,000 feet) from rim to river bottom, making it one of the deepest canyons in the United States. In just 6 million years, water had carved through rock layers that collectively represented more than 2 billion years of geological history, nearly half of the time Earth has existed.

#Carichiamo le librerie 
library(raster)
library(RStoolbox)
#settiamo la wd 
setwd("C:/lab/")

#L'immagine che utilizziamo è una RGB, è formata quindi da tre livelli, per caricare questo tipo di immagine utilizziamo la funzione brick 
gc <- brick("dolansprings_oli_2013088_canyon_lrg.jpg")
gc

#Visualizziamo la nostra immagine tramite la funzione plotRGB
#Abbiamo  un oggetto raster con più strati e attraverso questa funzione andiamo a plottarli 
plotRGB(gc, 1,2,3, stretch="lin")
#Cambiamo la visualizzazione tramite lo stretching da lineare a histogram dove vengono utitlizzate tutte le bande possibili per visualizzare l'immagine 
plotRGB(gc, 1,2,3, stretch="hist")

#Utilizziamo la funzione unsuperClass
gcc2 <- unsuperClass(gc, nClasses=2)
gcc2 #Visualizzo i dati 
plot(gcc2$map)

#Aumentiamo in numero di classi 
gcc4 <- unsuperClass(gc, nClasses=4)
gcc4 #Visualizzo i dati 
plot(gcc4$map)




