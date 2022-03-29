######
# Regresiones
######

library(tidyverse)
library(readxl)
library(stargazer)
library(lfe)

rm(list =ls())

# El objetivo es ver si la democracia tiene un efecto negativo sobre la desigualda. Para ello inclui controles


setwd('C:/Users/rodri/OneDrive - INSTITUTO TECNOLOGICO AUTONOMO DE MEXICO/Labs MIA/07_Regresion')

# primer control, pib
pwt<-readxl::read_excel('Data/pwt100.xlsx',
                        sheet = 'Data') %>% 
  rename(country=countrycode,
         country_name=country) %>% 
  mutate(year=as.numeric(year))
# medida de desigualda
gini<-read.csv('Data/economic-inequality-gini-index.csv') %>% 
  rename(gini=Gini.index,
         country=Code) %>% 
  mutate(year=as.numeric(Year))

# datos de democracia que ya habiamos usa
min<-readxl::read_excel('Data/WhoGov_crosssectional_V1.1.xlsx',
                        guess_max = 99999999) %>% 
  rename(country=country_isocode) %>% 
  mutate(year=as.numeric(year))

# hacemos el merge
in_equality<-list(pwt,gini,min) %>% 
  reduce(left_join, by=c('country','year'))

# generamos la dummy de democracia si la palabra democracia esta en system category
in_equality<- in_equality %>% mutate(
  rgdp_pc=rgdpo/pop,
  democracy=ifelse(str_detect(system_category, 'democracy')==T,1,0)
)


modelo1<-lm(gini ~ democracy,
            data=in_equality)

modelo2<-lm(gini ~ democracy+pop+ log(rgdpo) + emp + pop* emp,
           data=in_equality)

## Para hacer cosas mas sofisticadas como efectos fijos, variables instrumentales o errores agrupados usamos el paquete lfe

# usamos la funcion felm()

# ponemos el mismo modelo |efectos fijos| instrumento (0 si no)| errores
modelo3<-felm(gini ~ democracy+pop+ log(rgdpo) + emp + pop* emp |country+year|0|country ,
              data=in_equality)

tabla<-stargazer(modelo1, modelo2, modelo3,
                 type = 'text',
                 header = F,
                 title = 'Democracia y desigualdad',
                 column.labels = c('Regresión con controles', 'Efectos fijos y Errores agrupados'),
                 column.separate = c(2,1),
                 covariate.labels = c('Democracia',
                                      'Población',
                                      'PIB',
                                      'Empleo',
                                      '(Poblaicón*Empleo)'))

