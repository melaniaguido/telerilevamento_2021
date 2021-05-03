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





