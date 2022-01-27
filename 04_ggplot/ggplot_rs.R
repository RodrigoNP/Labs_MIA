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


# Recordemos como hicimos para crear el df #

min<- min %>% mutate(
  female=ifelse(gender=='Female',1,0))

min_grouped<- min %>% 
  group_by(year) %>% 
  summarise(
    fem_mean.year=mean(female,
                       na.rm=T) )

# Grafiquemos con ggplot #
# Este seria el grafico mas rudimentario
ggplot(data=min_grouped,
       aes(x=year, y=fem_mean.year))+
  geom_line() 

#podemos aniadir esteticas gradualmente
ggplot(data=min_grouped,
       aes(x=year, y=fem_mean.year))+
  geom_line()+
  ggtitle('Porcentaje de Mujeres en el gabinete por año')+
  xlab('Año')+
  ylab('')

# De hecho, podemos aniadir figuras, como una linea horizontal

ggplot(data=min_grouped,
       aes(x=year, y=fem_mean.year))+
  geom_line()+
  ggtitle('Porcentaje de Mujeres en el gabinete por año')+
  xlab('Año')+
  ylab('')+
  geom_hline(yintercept = with(min_grouped, mean(fem_mean.year)), color='red')

## Datos agrupados ##

# Despues del merge tenemos informacion de regimen. Queremos graficar agrupando por regimen. Primero necesitamos crear el df

min_regime<-min %>% group_by(system_category) %>% summarise(
  fem.mean_regime=mean(female,
                       na.rm=T)
)

# Esta vez queremos hacer un grafico de barras

ggplot(min_regime,
       aes(system_category, fem.mean_regime,
           fill=system_category))+
  geom_bar(stat = 'identity')+ #stat=identity es para que no se apilen las barras
  theme_minimal() # theme cambia el estilo: hay varias opciones

# notamos que las letras se apilan, asi que busque en internet como hacer para cambiar su angulo

ggplot(min_regime,
       aes(system_category, fem.mean_regime,
           fill=system_category))+
  geom_bar(stat = 'identity')+
  xlab('')+
  theme_minimal()+
  theme(axis.text.x = element_text(angle=40, hjust=1),
        panel.grid.major.y = element_line())

