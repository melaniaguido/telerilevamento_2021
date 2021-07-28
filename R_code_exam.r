#R_code_exam.r
#Analisi manto nevoso della Sierra Nevada nell'arco temporale 2006-2021

#Setto la wd 
setwd("C:/lab/")

#Importo le librerie che mi serviranno 
library(raster)
library(RStoolbox) #Ci serve per la classificazione 
library(ggplot2) 

#Importo le immagini su cui andrò a lavorare 
nevada1 <- brick("nevada2006.jpg")
nevada2 <- brick ("nevada2021.jpg")

#Plottiamo le due immagini insieme utilizzando par 
par(mfrow=c(2,1))
plotRGB(nevada1, r=1, g=2, b=3, stretch="Lin")
plotRGB(nevada2, r=1, g=2, b=3, stretch="Lin")

library(gridExtra)
#Vado a fare il plot delle due immagine utilizzando ggRGB
p1 <- ggRGB(nevada1, r=1, g=2, b=3, stretch="lin")
p2 <- ggRGB(nevada2, r=1, g=2, b=3, stretch="lin")
grid.arrange(p1, p2, nrow=2) #grafici in una pagina

#Classificazione non supervisionata 
d1c <- unsuperClass(nevada1, nClasses=2)
#Facciamo il plot 
plot(d1c$map)
#Modifichiamo la palette colori 
cl <- colorRampPalette(c('black','green'))(100) 
plot(d1c$map, col=cl)


d2c <- unsuperClass(nevada2, nClasses=2)
plot(d2c$map, col=cl)

par(mfrow=c(2,1))
plot(d1c$map, col=cl)
plot(d2c$map, col=cl)

d2c3 <- unsuperClass(nevada1, nClasses=3)
plot(d2c3$map)


#pixel di ciascuna classe 
 freq(d1c$map)
     value    count
[1,]     1  7310428
[2,]     2 11629476
s1 <-  7310428 + 11629476 #Somma di tutti i pixel

#Qual è la frequenza dei pixel di neve? 
prop1 <- freq(d1c$map)/s1 #Otteniamo così le proporzioni
value     count
[1,] 5.279858e-08 0.3859802  38% 
[2,] 1.055972e-07 0.6140198  62%

#seconda mappa 
freq(d2c$map)
     value   count
[1,]     1 9034654
[2,]     2 9905250
s2 <- 9034654 +  9905250
prop2 <- freq(d2c$map)/s2
prop2
            value     count
[1,] 5.279858e-08 0.4770169 48%
[2,] 1.055972e-07 0.5229831 52%

Andiamo a generare un dataset che in r si chiama dataframe 
cover <- c("Forest","snow") #cover è formata dalle componenti forest e snow
percent_2006 <- c(38.59, 61.40) 
percent_2021 <- c(47.70, 52.29)
#data.frame è la funzione che mi permette di creare i dataframe in r
percentages <- data.frame(cover, percent_2006, percent_2021) #Andiamo a definire le colonne 
percentages
#cover percent_2006 percent_2021
1 Forest        38.59        47.70
2   snow        61.40        52.29.07

#Andiamo a fare il plot 
#La funzione ggplot e plotta un dataset e poi ha una parte chiamata aestetich, scriviamo la prima e la seconda colonna  e il colore 
#Attraverso geom_bar vado a definire la visualizzazione 
ggplot(percentages, aes(x=cover, y=percent_2021, color=cover)) + geom_bar(stat="identity", fill="white")

#Andiamo a fare il plot di tutte e due utilizzando ggplot 
p1 <- ggplot(percentages, aes(x=cover, y=percent_2006, color=cover)) + geom_bar(stat="identity", fill="white")
p2 <- ggplot(percentages, aes(x=cover, y=percent_2021, color=cover)) + geom_bar(stat="identity", fill="white")
grid.arrange(p1, p2, nrow=1) #Attraverso grid.arrange andiamo a mettere i due grafici vicini nello stessa pagina 


















