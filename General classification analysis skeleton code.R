Analysing the data using the DirichletReg distribution

#You will need to wrangle your data so for each group (e.g. quadrat) each histogram class count is in a seperate column as well as each #class proportion (i.e factor 1, factor 2, class 1, class 2, class n, class 1 prop, class 2 prop, class n prop)
#1) Import data
data1 <- read.table(file="class bleach 15.1.txt", header= TRUE,dec=",", na.strings=c("",".","NA")) 
head(data1)
options(scipen = 999)  # turn off scientific notation


#Organising
data1$raw.x <- as.numeric(as.character(data1$raw.x))
data1$titan.p <- as.numeric(as.character(data1$titan.p))
data1$peys.p <- as.numeric(as.character(data1$peys.p))
data1$dead.p <- as.numeric(as.character(data1$dead.p))
data1$bleached.p <- as.numeric(as.character(data1$bleached.p))
nrow(data1)
library(dplyr)
detach(package:plyr)


#Visulise data
library(tidyr)
data2 = data1[-c(4:8)]
data2.long = gather(data2, class, prop, titan.p:bleached.p)
library(ggplot2)
p0 = ggplot()+geom_point(data2.long, mapping = aes(x = raw.x, y = prop))+facet_wrap(~time+class)+scale_x_log10(name ="dep sed")
p0


#Model
library(DirichletReg)
data4 = data2[,1:3]  #subset the predicitors
data4$props = DR_data(data2[, 4:7])   #group the proportions and add back to dataframe
mod0 <- DirichReg(props ~ 1, data4)
mod1 <- DirichReg(props ~ raw.x, data4)
mod2 <- DirichReg(props ~ raw.x+time, data4)
mod3 <- DirichReg(props ~ raw.x*time, data4)
anova(mod0, mod1, mod2, mod3)  #mod3 best model
AIC( mod3)  #interactive model best
summary(mod3)


#Fitting and plotting
vec.x = seq(0.01, 300, 10)
exp.df2 <- expand.grid(raw.x  = vec.x, 
                       time     = levels(data2$time))
ff1 = as.data.frame(predict(mod3, newdata = exp.df2))
df1 = bind_cols(exp.df2, ff1)  #cobine two dataframes to make wide prediction df
colnames(df1) <- c("raw.x", "time","titan.p", 'peys.p', 'dead.p', 'bleached.p')
library(tidyr)
df1.long = gather(df1, class, prop, titan.p:bleached.p)
library(ggplot2)
p0 = ggplot(data2.long, mapping = aes(x = raw.x, y = prop))+geom_point(data2.long, mapping = aes(x = raw.x, y = prop))
p0 = p0 + geom_line(df1.long,  mapping = aes(x = raw.x, y = prop))
p0 = p0 +facet_wrap(~time+class)
p0 = p0 +scale_x_log10(name ="dep sed")
p0