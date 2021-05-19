#R_code_variability.r 

#Carichiamo le librerie che ci serviranno 
library(raster)
library(RStoolbox)
library(ggplot2)
library(viridis)
library(gridExtra)

#settiamo la wd 
setwd("C:/lab/")

#Importiamo l'immagine 
sentinel <- brick("sentinel.png")
sentinel
plotRGB(sentinel) #Visualizziamo l'immagine 

#
sentinel_pca <- rasterPCA(sentinel)








