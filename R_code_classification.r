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



