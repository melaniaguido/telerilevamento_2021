#R_code_knitr.r

setwd("C:/lab/") 

#knitr all'interno di R genera un report
library(knitr) #richiamo il pacchetto knitr 

#Utilizziamo la funzione stitch, come prima cosa dobbiamo inserire come si chiama il nostro codice 
#gli altri argomenti sono il template che utilizziamo, misc e il file del template
#inseriamo poi il nome del pacchetto da utilizzare 
stitch("R_code_Greenland.r.txt", template=system.file("misc", "knitr-template.Rnw", package="knitr"))

