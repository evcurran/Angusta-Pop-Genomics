
setwd("C:/Users/evcur/Google Drive/Grass/angusta/ABBABABA/abbababa")

# load data
data<-read.table('abbababab.txt',header=T)

# specify groups
semialata<-c("ZAM17-23-05","ZAM15-05-10","ZAM17-01-1_7","ZAM17-05-03","AS-TAN16-03-01","AS-ZAM15-03-03","AS-ZAM15-07-19")
erect<-c("a4003","a4006","AS-TAN16-01-51","Asem-PA1","JKO-01-02","ZAM-19-33-01","ZAM-20-74-15","ZAM17-20-04")
decumbent<-c("ZAM20-75-04","ZAM19-30-17","ZAM19-50-10","MRL48","PA-3C")
cladeII<-c("ZAM17-23-05","ZAM17-05-03","AS-ZAM15-03-03","AS-ZAM15-07-19")
cladeIII<-c("ZAM15-05-10","ZAM17-01-1_7","AS-TAN16-03-01")



# identify most frequent H1 within angusta
data2<-data[((data$H3 %in% erect & data$H2 %in% decumbent & data$H1 %in% decumbent) | (data$H3 %in% decumbent & data$H2 %in% erect & data$H1 %in% erect)),]
data2$pbon <- p.adjust(data2$pval, method = "bonferroni", n = length(data2$pval))
data2$H1<-as.character(data2$H1)
data2$H2<-as.character(data2$H2)
for(i in 1:dim(data2)[1]){
  if(data2$Dstat[i]<0){
    name=data2$H1[i]
    data2$H1[i]<-data2$H2[i]
    data2$H2[i]<-name
    data2$Dstat[i]<--data2$Dstat[i]
  }
}

# Most frequent H1 for decumbent = a4003 (n=35)
table(data2$H1[data2$H3 %in% decumbent])

# Most frequent H1 for erect = MRL48 (n=17)
table(data2$H1[data2$H3 %in% erect])


# Subset erect with H1 = a4003
data3<-data2[data2$H1=="a4003" | data2$H2=="a4003",]
data3$H1<-as.character(data3$H1)
data3$H2<-as.character(data3$H2)
for(i in 1:dim(data3)[1]){
  if(data3$H2[i]=="a4003"){
    data3$H2[i]<-data3$H1[i]
    data3$H1[i]<="a4003"
    data3$Dstat[i]<--data3$Dstat[i]
  }
}
data3$H2<-factor(data3$H2,levels=c("AS-TAN16-01-51","Asem-PA1","ZAM-20-74-15","a4006","ZAM-19-33-01","ZAM17-20-04","JKO-01-02"))


# Subset decumbent with H1 = PA-3C
data4<-data2[data2$H1=="PA-3C" | data2$H2=="PA-3C",]
data4$H1<-as.character(data4$H1)
data4$H2<-as.character(data4$H2)
for(i in 1:dim(data4)[1]){
  if(data4$H2[i]=="PA-3C"){
    data4$H2[i]<-data4$H1[i]
    data4$H1[i]<-"PA-3C"
    data4$Dstat[i]<--data4$Dstat[i]
  }
}
data4$H2<-factor(data4$H2,levels=c("MRL48","ZAM20-75-04","ZAM19-50-10","ZAM19-30-17"))

# combining within angusta comparisons 
data34 <- rbind(data3, data4)
#write.csv(data34, "angusta_within_abbababa_plot.csv")
plot_ang <- read.csv("angusta_within_abbababa_plot.csv")
plot_ang <- plot_ang[order(plot_ang$tree_order),]
H2_labs <- c("ZAM1720-04", "ZAM1933-01", "ZAM1930-JKO0102", "MAW1", "ZAM2074-15", "COD1", "TAN1601-51", "TAN1", "UGA1", "UGA4", "ZAM2075-04", "ZAM1930-17", "ZAM1950-10")

# Plot the within-angusta D-scores
pdf("boxplot_within_ang.pdf",useDingbat=F)
par(mar=c(8,5,1,1))

library("RColorBrewer")
boxplot(plot_ang$Dstat~factor(plot_ang$tree_order),ylim=c(min(na.exclude(plot_ang$Dstat)), max(na.exclude(plot_ang$Dstat))),outline=F, ylab="D", xlab = "", xaxt='n', cex.axis = 1.5, cex.lab=1.5)
axis(side=1,labels=F,at = c(1,2,3,4,5,6,7,8,9,10,11,12,13))
grid (14,0, lty = 1)
cpal <- brewer.pal(12, "Paired")
points(plot_ang$Dstat[plot_ang$H3=="MRL48"]~factor(plot_ang$tree_order[plot_ang$H3=="MRL48"]),pch=17,col=cpal[1],cex=2)
points(plot_ang$Dstat[plot_ang$H3=="PA-3C"]~factor(plot_ang$tree_order[plot_ang$H3=="PA-3C"]),pch=17,col=cpal[6],cex=2)
points(plot_ang$Dstat[plot_ang$H3=="ZAM20-75-04"]~factor(plot_ang$tree_order[plot_ang$H3=="ZAM20-75-04"]),pch=17,col=cpal[3],cex=2)
points(plot_ang$Dstat[plot_ang$H3=="ZAM19-50-10"]~factor(plot_ang$tree_order[plot_ang$H3=="ZAM19-50-10"]),pch=17,col=cpal[10],cex=2)
points(plot_ang$Dstat[plot_ang$H3=="ZAM19-30-17"]~factor(plot_ang$tree_order[plot_ang$H3=="ZAM19-30-17"]),pch=17,col=cpal[5],cex=2)

points(plot_ang$Dstat[plot_ang$H3=="a4003"]~plot_ang$tree_order[plot_ang$H3=="a4003"],pch=16,col=cpal[2],cex=2)
points(plot_ang$Dstat[plot_ang$H3=="a4006"]~plot_ang$tree_order[plot_ang$H3=="a4006"],pch=16,col=cpal[7],cex=2)
points(plot_ang$Dstat[plot_ang$H3=="AS-TAN16-01-51"]~plot_ang$tree_order[plot_ang$H3=="AS-TAN16-01-51"],pch=16,col=cpal[4],cex=2)
points(plot_ang$Dstat[plot_ang$H3=="Asem-PA1"]~plot_ang$tree_order[plot_ang$H3=="Asem-PA1"],pch=16,col=cpal[9],cex=2)
points(plot_ang$Dstat[plot_ang$H3=="JKO-01-02"]~plot_ang$tree_order[plot_ang$H3=="JKO-01-02"],pch=16,col=cpal[8],cex=2)
points(plot_ang$Dstat[plot_ang$H3=="ZAM-19-33-01"]~plot_ang$tree_order[plot_ang$H3=="ZAM-19-33-01"],pch=16,col=cpal[11],cex=2)
points(plot_ang$Dstat[plot_ang$H3=="ZAM-20-74-15"]~plot_ang$tree_order[plot_ang$H3=="ZAM-20-74-15"],pch=16,col=cpal[12],cex=2)
points(plot_ang$Dstat[plot_ang$H3=="ZAM17-20-04"]~plot_ang$tree_order[plot_ang$H3=="ZAM17-20-04"],pch=16,col="black",cex=2)

dev.off()


# semialata versus angusta tests, identify most frequent H1

data5<-data[data$H3 %in% semialata & ! data$H1 %in% semialata & !data$H2 %in% semialata,]
data5$pbon <- p.adjust(data5$pval, method = "bonferroni", n = length(data5$pval))

data5$H1<-as.character(data5$H1)
data5$H2<-as.character(data5$H2)
for(i in 1:dim(data5)[1]){
  if(data5$Dstat[i]<0){
    name=data5$H1[i]
    data5$H1[i]<-data5$H2[i]
    data5$H2[i]<-name
    data5$Dstat[i]<--data5$Dstat[i]
  }
}

# Most frequent H1 = PA-3C (n=81)
table(data5$H1)

# Subset semialata versus angusta tests, with H1 = PA-3C

data6<-data5[data5$H1=="PA-3C" | data5$H2=="PA-3C",]
data6$H1<-as.character(data6$H1)
data6$H2<-as.character(data6$H2)

#write.csv(data6, "ang_sem_bw_abbababa_plot.csv")
data6 <- read.csv("ang_sem_bw_abbababa_plot.csv")
data6 <- data6[order(data6$tree_order),]
H2_labs <- c("ZAM1720-04", "ZAM1933-01", "ZAM1930-JKO0102", "MAW1", "ZAM2074-15", "COD1", "TAN1601-51", "TAN1", "UGA1", "UGA4", "ZAM2075-04", "ZAM1930-17", "ZAM1950-10")


for(i in 1:dim(data6)[1]){
  if(data6$H2[i]=="PA-3C"){
    data6$H2[i]<-data6$H1[i]
    data6$H1[i]<-"PA-3C"
    data6$Dstat[i]<--data6$Dstat[i]
  }
}
data6$H2<-factor(data6$H2,levels=c("ZAM17-20-04","ZAM-19-33-01","JKO-01-02","a4006","ZAM-20-74-15","Asem-PA1","AS-TAN16-01-51","a4003","MRL48","ZAM20-75-04","ZAM19-30-17","ZAM19-50-10"))

# Plot D-scores
pdf("boxplot_bw_ang_sem.pdf",useDingbat=F)
par(mar=c(8,5,1,1))
boxplot(data6$Dstat~factor(data6$tree_order),ylim=c(min(na.exclude(data6$Dstat)), max(na.exclude(data6$Dstat))),outline=F, ylab="D", xlab = "", xaxt='n', cex.axis = 1.5, cex.lab=1.5)
axis(side=1,labels=F,at = c(1,2,3,4,5,6,7,8,9,10,11,12,13))
grid (14,0, lty = 1)
points(data6$Dstat[data6$pbon<0.05]~data6$tree_order[data6$pbon<0.05],pch=16,cex=2)
points(data6$Dstat[data6$pbon>0.05]~data6$tree_order[data6$pbon>0.05],pch=1,cex=2)

dev.off()

