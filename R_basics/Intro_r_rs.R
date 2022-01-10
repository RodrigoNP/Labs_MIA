######
# Intro a R
######
rm(list=ls()) #Borra variables antes guardadas en el environment


## Creacion de objetos ##

#Creamos objetos con <- , =  o ->

# Hay muchos tipos de objetos, veamos los mas basicos

numeric.var<-1
character.var<-'Mexico'
factor.var<-factor(1, labels = 'one')
logic.var<- TRUE #Booleanos # TRUE= T, FALSE= F

#Observemos que se guardan en el environment

#Si los ejecutamos, R los muestra, de preferencia, hacerlo en la consola. 

numeric.var

#Podemos preguntarle a R si un objeto es de algun tipo

is.numeric(numeric.var)

#Podemos usar el comando as. para cambiar el tipo de variable
as.character(numeric.var)
as.numeric(numeric.var)
as.factor(character.var)

#Modificar un objeto lo sobreescribe: NO GUARDA DOS VERSIONES. 

numeric.var<-3+sqrt(9)+9^4-4+9/7

#Recordemos que la consola no guarda, asi que ahi podemos hacer calculos rápidos

sqrt(numeric.var)

## Characters ##
#Son un pedazo de texto encerrado entre comillas.Podemos usar dos comillas, alt+2 o podemos usar el apostrofe debajo del signo de interrogacion-> mas rapido ' 

name<-'Rodrigo'

## Logicos o Booleanos ##
# TRUE o FALSE 
# Podemos preguntarle algo a R y nos contesta con un TRUE o FALSE
a<-59

a>100

# Como en casi todos los lenguajes, los operadores son 
# & 'y'
# | 'o'
# == 'igual'
# >= 'mayor o igual' 

#Algo particularmente util es que T=1 y F=0

T+3

# Ejemplos booleanos
is.logical(is.numeric(FALSE))
is.numeric(2)+is.character('hola')
T|F
T & F

## Factores ##
#Son variables categoricas mutuamente excluyentes. Se ven como characters, pero tienen niveles. 

consolas<-as.factor('xbox')

#podemos aniadir niveles de una manera mas sencilla
levels(consolas)<-c('xbox','switch','ps5')

consolas

## Vectores o listas ##

#Podemos concatenar objetos usando el comando c(). De preferencia, que sean del mismo tipo. Un vector es una lista de objetos, una coleccion. 

vector<-c(1,4,5,6)
vector<-c(vector, 1,4,6,8,9)

## Slices ##

# Podemos ver partes especificas de los vectores utilizando parentesis.
#Dentro de los parentesis ponemos las posiciones deseadas del vector.

vector[3]

#Un operador habital es ':' que se interpreta como de x a y

vector[1:2] #dame los objetos que estan de la posicion uno a la dos


#Podemos hacer particiones de vectores usando operadores logicos
vector[vector<5]
#Para obetener el complemento de ese vector
vector[!vector<5]


#Con este mismo operador podemos hacer series

series<-1:10
series

#Muchas funciones utilizan vectores
mean(vector); sd(vector) ; prod(vector)

#incluso, puedes operar con los mismos vectores. Interpretalo como vectores matematicos: OPERACIONES ENTRADA POR ENTRADA

r<-c(1,4,6,4,2,5,9)
r*2
r+r
r>=4

#Como vimos, podemos utilizar factores para ver cuantas observaciones pertenecen a una categoria

carreras<-c('eco','eco','cpol','ri','ri')
as.factor(carreras)

table(carreras)

# usamos el operador '%in%' para ver si un objeto pertenece a un vector

carreras<-c('eco','eco','cpol','ri','ri')

'mat' %in% carreras

# Para las simulaciones, seguramente usaremos estas funciones

rep(4,4) #repite la primera entrada la cantidad de veces indicada en la segunda entrada
a<-c(1,7,9)
rep(a,3)

numeric(5) #vector de 0 el numero de veces indicada

character(6) # lo mismo, pero para characters

sample(1:10,3) #Del vector indicado,toma una muestra aleatoria del tamanio indicado en la segunda entrada
a<-c(2,4,5,6,1,3,12,45,56)
sample(a,4)
sample(a, 2, replace = F) #podemos indicar con o sin reemplazo

#Podemos tomar particiones usando vectores independientes

coin_toss<-sample(
  rep(c('aguila', 'sol')), 10 , 
  replace = T)

y<-1:10

y[coin_toss=='aguila']

### Ejercicios de Mauricio Romero ### 
#Si f es
f <- c(2,3,4,5)
# que output dara lo siguiente

f^2
f + c(1,2,3,4)
c(f,6)
is.numeric(f)
mean(f >= 4)
f*c(1,2,3)
length(f)
length(rep(1:4,3))
f/2 == 2 | f < 3
as.character(f)
f[1]+f[4]
c(f,f,f,f)
f[f[1]]
f[c(1,3)]
f %in% (1:4*2)

sort(c(1,5,3,7,45,6,23,-45))

