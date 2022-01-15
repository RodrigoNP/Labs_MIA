######
# ggplot
######

#Cargamos librerias
library(tidyverse)

#Cambiamos el directorio
setwd('C:/Users/rodri/OneDrive - INSTITUTO TECNOLOGICO AUTONOMO DE MEXICO/Labs MIA/ggplot')

# Descargamos las bases de datos
min_within<-readxl::read_excel('WhoGov_within_V1.1.xlsx', 
                               guess_max=999999999)

min_cross<-readxl::read_excel('WhoGov_crosssectional_V1.1.xlsx', guess_max=9999999)

## Merge ##
# Hay muchas maneras de hacer el merge, pero intentemos uno por izquierda

min<-left_join(min_within, min_cross,
               by=c('year'='year', 'country_name'='country_name'))

# aparece un error los anios son de tipo diferente, podemos corregirlo facilmente

#convirtamos ambos a numericos
min_cross$year<-as.numeric(min_cross$year)
min_within$year<-as.numeric(min_within$year)

# Intentemos de nuevo el merge
min<-left_join(min_within, min_cross,
               by=c('year'='year', 'country_name'='country_name')) 



