######
# Potential Outcomes
#####

library(tidyverse)

## Generamos los P.O. 

set.seed(2022)
n<-10000
i<-1:n
y0<-rnorm(n, 30, 10)
y1<-rnorm(n, 50, 35)
df<-data.frame(i,y0,y1)

# Cargamos randomizr para asignar más facilmente el tratamiento
library(randomizr)

# Asignamos el tratamiento
df<-mutate(df, t=complete_ra(n))


# Ya con el tratamiento, ponemos la y observada
df<-mutate(df,y_observada=y0+(y1-y0)*t)

# Podemos poner el efecto causal individual

df<-mutate(df, delta=y1-y0)

# Para ver cuantos tienen un efecto negativo
length(df[y0>y1, ])

## Efectos causales ##
ate<-with(df, mean(delta))
att<-with(filter(df, t==1), mean(delta))
atc<-with(filter(df, t==0), mean(delta))
ci<-with(filter(df, t==1), 
         mean(y_observada))- 
  with(filter(df, t==0), 
       mean(y_observada))

## Simulaciones ##

set.seed(2022)
#semilla
numrep<-5000
n<-10000

ate_estimates<-NULL #vectores vacios
ci_estimates<-NULL  # para guardar datos

for (i in 1:numrep) {
  # Creacion df
  df<-data.frame(i=1:n,
                 y0=rnorm(n, 30, 10),
                 y1=rnorm(n, 50, 35),
                 t=complete_ra(n)) %>% 
    mutate(y_observada=y0+(y1-y0)*t,
           delta=y1-y0)
  
  # Calculo efectos causales
  # Debemos guardarlos como entrada en vectores
  ate_estimates[i]<- with(df, mean(delta))
  
  ci_estimates[i]<- with(filter(df, t==1), 
                         mean(y_observada))- 
    with(filter(df, t==0), 
         mean(y_observada))        
}

# Para graficar los dos histogramas juntos

ggplot()+
  geom_histogram(aes(ate_estimates),
                 fill='red', alpha=.5, 
                 bins = 100)+
  geom_histogram(aes(ci_estimates),
                 fill='blue', alpha=.5,
                 bins=100)+
  geom_vline(xintercept = mean(ate_estimates),
             color='red')+
  geom_vline(xintercept = mean(ci_estimates),
             color='blue')+
  xlab('')

# Para graficar un solo histograma
error_estimates<-ate_estimates-
  ci_estimates

ggplot()+
  geom_histogram(aes(x=error_estimates),
                 bins = 100)+
  geom_vline(xintercept = 
               mean(error_estimates))