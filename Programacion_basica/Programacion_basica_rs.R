######
# Programacion Basica
######

rm(list=ls())

# Creemos de nuevo del df de alumnos del ITAM

set.seed(2020)
n<-4000
df<-data.frame(
  id=1:n,
  sex=sample(c('h','m','o'), n, replace = T),
  edad=floor(runif(n, min=17, max=27)),
  carrera=sample(c('eco','cpol','ri','derecho','conta','mat'), n, replace = T),
  prom=runif(n, 6, 10)
)

with(df, mean(prom))

## For loops ##

# Si queremos hacer esto varias veces, conviene hacer un foor loop

# Necesitamos un vector vacio para guardar los promedios

means<-NULL

# se acostumbra crear una variable que indique el # de repeticiones para despues modificar facilmente

num.reps<-5000

for (i in 1:num.reps) {
  df<-data.frame(
    id=1:n,
    sex=sample(c('h','m','o'), n, replace = T),
    edad=floor(runif(n, min=17, max=27)),
    carrera=sample(c('eco','cpol','ri','derecho','conta','mat'), n, replace = T),
    prom=runif(n, 6, 10)) #Creamos el df
  means[i]<-with(df, mean(prom)) #Guardamos en el vector
}

## Para hacer la gráfica
(plot(density(means),
      ylab='',
      main = ''))

## Loops sobre variables ##
# usemos una base de datos precargada

data(mtcars)

for (i in c('mpg','hp','qsec','cyl')) {
  print(mean(mtcars[[i]]))
}

# mpg, hp, qsec y cyl son variables del df mtcars. Para hacer un loop sobre variables ponemos df[[i]]

#para imprimir mensaje usamos la funcion past0()

for (i in c('mpg','hp','qsec','cyl')) {
  print(
    paste0(c('El promedio de',i, 'es', mean(mtcars[[i]])))
    )
}

!20%%2


## if ## 
# Sirve cuando queremos que R haga algo solo en ciertos casos

if(2>0){
  print('Hola')
}
# En caso de que no se cumpla la condicion, no hace nada

## else ##
# Si queremos que haga algo en caso de que la condicion sea falsa 

a<-rnorm(1, mean=0, sd=1)
if(a>0){
  print('Hola')
} else {
  print('Adiós ')
}

## Nested loops ##
# Podemos mezclar if y for
# Necesitamos next y break
# Next pasa al proximo elemento del iterador
# break rompe el ciclo

for (i in 57:65) {
  if(!i %%2){
    print(i)
    next
  }
}

for (i in 57:65) {
  if(!i %%2){
    print(i)
    break
  }
}


## Funciones ## 
# Podemos crear nuestras propias funciones 
# func_name <-**function**(input){
#   statement
# return (output)
# }

# Por ejemplo, pensemos en una función que, si le pongo el df de alumnos del ITAM, calcule el promedio de los promedios por carrera.

# Recordemos la base de datos
n<-4000
df<-data.frame(
  id=1:n,
  sex=sample(c('h','m','o'), n, replace = T),
  edad=floor(runif(n, min=17, max=27)),
  carrera=sample(c('eco','cpol','ri','derecho','conta','mat'), n, replace = T),
  prom=runif(n, 6, 10)
)

# Pensemos en la funcion
career.mean<-function(data_frame){
  career_mean<-NULL
  for (i in df$carrera ) {
  career_mean[i]<-with(subset(df, carrera==i), mean(prom))
  }
  return(career_mean)
}

career.mean(df)

## Algunas aclaraciones sobre funciones ## 
potencia<- function(x, y=2) {
  result<-x^y
  return(result)
}

potencia(2)
potencia(2,4)
