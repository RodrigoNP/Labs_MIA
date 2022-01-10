######
# Data Frames
######

rm(list=ls())

## Creacion de DF## 
# Aprovechemos lo que aprendimos para crear un DF. 

n<-4000
id<-1:n
sex<-sample(c('h','m','o'), n, replace = T)
edad<-floor(runif(n, min=17, max=27)) # Se pueden omitir las palabras max y min y solo poner los numeros
carrera<-sample(c('eco','cpol','ri','derecho','conta','mat'), n, replace = T)
prom<-runif(n, 6, 10)


# Cramos DF con la funcion data.frame()
df<-data.frame(id, sex, edad, carrera, prom)

## Semillas ##
# Por replicabilidad, siempre hay que correr una semilla para que se puedan obtener los mismo datos aleatorios

set.seed(2020)
df<-data.frame(
  id=1:n,
  sex=sample(c('h','m'), n, replace = T),
  edad=floor(runif(n, min=17, max=27)),
  carrera=sample(c('eco','cpol','ri','derecho','conta','mat'), n, replace = T),
  prom=runif(n, 6, 10)
) #manera alternativa de crear el df directamente, sin crear nuevas variables

## Visualizaciones del df ##
# Muchas maneras de darnos una idea de lo que contiene un df
summary(df)
head(df)
str(df)

## Particiones de DF ## 
# Podemos llamar los vectores de las variables con "$"

df$prom

#Podemos operar con este vector como con cualquier otro

mean(df$prom)
df$prom[5]

# podemos tomar rebanadas del df: 
# df[filas, columnas]

df[1:2, c(2:3,5)]

## Algunas funciones importantes para DF

# with #
with(df, mean(prom))

# subset #
# Para tomar subconjuntos de las bases de datos
df_female_ri<-subset(df, sex=='m' & carrera=='ri')

# ifelse() #
# Es muy util para crear dummies. 
df$female<-ifelse(sex=='m', 1, 0)
df


