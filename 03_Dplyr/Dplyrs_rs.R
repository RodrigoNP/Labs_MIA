######
# Data Pliers
#####

rm(list = ls())

## Cargamos paquetes (recuerda instalarlos antes)##
# instalamos con: install.packages('paquete')

library(tidyverse)



## Directorio ## 

# podemos verificar en qué directorio estamos trabajando actualmente
getwd()


# Modificando el directorio #
setwd('C:/Users/rodri/OneDrive - INSTITUTO TECNOLOGICO AUTONOMO DE MEXICO/Labs MIA/Dplyr')

min<-readxl::read_excel('WhoGov_within_V1.1.xlsx',
                        guess_max = 99999 ) #como modificamos el directorio, solo hay que poner el nombre del archivo

# LLamando directamente al archivo #
min<- read_excel('C:/Users/rodri/OneDrive - INSTITUTO TECNOLOGICO AUTONOMO DE MEXICO/Labs MIA/Dplyr/WhoGov_within_V1.1.xlsx', guess_max = 99999)

## Pipa ##
# La pipa, %>% , es el operador mas usado. Denota: al df de la izquierda le aplico la funcion de la derecha

## mutate() ##
#Podemos aniadir variables con mutate
min<- min %>% 
  mutate(
    female=ifelse(gender=='Female',1,0)
  )

min<-mutate(min, female=ifelse(gender=='Female',1,0))

## filter() ##
# Usamos filter para quedarnos con observaciones que cumplan ciertos criterios: que produzcan un TRUE

min_fem.core<- min %>% filter(gender=='Female'
                              & core==1)

## select() ##
# select hace lo mismo que filter, pero para variables

min_fem.core<- min %>% 
  mutate(
    female=ifelse(gender=='Female',1,0)
  ) %>% filter(gender=='Female'
               & core==1)

## Agrupar ##
# podemos agrupar con group_by()
# Despues, podemo aniadir variables o comprimir la base de datos con summarise()

min<- min %>% 
  group_by(year) %>% 
  mutate(
    fem_mean.year=mean(female,
                       na.rm=T)
  )

min_grouped<- min %>% 
  group_by(year) %>% 
  summarise(
    fem_mean.year=mean(female,
                       na.rm=T)
  )

min_grouped

## case_when() ##
# Case_when() puede ser contraintuitiva, hagamos un ejemplo

min_equitativo<-min %>% 
  group_by(year, country_isocode) %>% 
  mutate(
    fem_mean.year.country=mean(female,
                               na.rm=T),
    equit=case_when(
      fem_mean.year.country<.15~'deficiente',
      
      fem_mean.year.country>=.15 
      & fem_mean.year.country<.4 ~ 'moderado',
      
      fem_mean.year.country>=.4 
      & fem_mean.year.country<.55 ~ 'equitativo',
      
      fem_mean.year.country>55 ~ 'elevado',
      
      T ~ 'no aplica'
    )) 

## Merges ##
help("left_join")
