library("tidyr")
library("fields")
library("ecodist")
library("dplyr")

setwd("C:/Users/evcur/Google Drive/Grass/angusta/ibd")

d <- read.csv("pairwise_fst_geo_ibd.csv")


within_erect_geo <- NULL
within_erect_fst <- NULL

within_dec_geo <- NULL
within_dec_fst <- NULL

between_ere_dec_geo <- NULL
between_ere_dec_fst <- NULL


for(i in 1:nrow(d)){
  if(d$pop1_type[i] == "ere" & d$pop2_type[i] == "ere"){
    within_erect_geo <- rbind(within_erect_geo, data.frame(d$pop1[i], d$pop1_type[i], d$pop2[i], d$pop2_type[i], d$dist_km[i]))
    within_erect_fst <- rbind(within_erect_fst, data.frame(d$pop1[i], d$pop1_type[i], d$pop2[i], d$pop2_type[i], d$fst[i]))
    
  } else if(d$pop1_type[i] == "dec" & d$pop2_type[i] == "dec"){
    within_dec_geo <- rbind(within_dec_geo, data.frame(d$pop1[i], d$pop1_type[i], d$pop2[i], d$pop2_type[i], d$dist_km[i]))
    within_dec_fst <- rbind(within_dec_fst, data.frame(d$pop1[i], d$pop1_type[i], d$pop2[i], d$pop2_type[i], d$fst[i]))
    
  } else if(d$pop1_type[i] == "ere" & d$pop2_type[i] == "dec"){
    between_ere_dec_geo <- rbind(between_ere_dec_geo, data.frame(d$pop1[i], d$pop1_type[i], d$pop2[i], d$pop2_type[i], d$dist_km[i]))
    between_ere_dec_fst <- rbind(between_ere_dec_fst, data.frame(d$pop1[i], d$pop1_type[i], d$pop2[i], d$pop2_type[i], d$fst[i]))
    
  } else if(d$pop1_type[i] == "dec" & d$pop2_type[i] == "ere"){
    between_ere_dec_geo <- rbind(between_ere_dec_geo, data.frame(d$pop1[i], d$pop1_type[i], d$pop2[i], d$pop2_type[i], d$dist_km[i]))
    between_ere_dec_fst <- rbind(between_ere_dec_fst, data.frame(d$pop1[i], d$pop1_type[i], d$pop2[i], d$pop2_type[i], d$fst[i]))

  }
  
}



# separate matrices

# within erect

within_erect_fst_ <- pivot_wider(data.frame(within_erect_fst$d.pop1.i., within_erect_fst$d.pop2.i., within_erect_fst$d.fst.i.), names_from = within_erect_fst.d.pop1.i., values_from = within_erect_fst.d.fst.i.)
within_erect_fst__ <- within_erect_fst_[-1]
row.names(within_erect_fst__) <- within_erect_fst_$within_erect_fst.d.pop2.i.
within_erect_fst_matrix <- as.matrix(within_erect_fst__)

within_erect_geo_ <- pivot_wider(data.frame(within_erect_geo$d.pop1.i., within_erect_geo$d.pop2.i., within_erect_geo$d.dist_km.i.), names_from = within_erect_geo.d.pop1.i., values_from = within_erect_geo.d.dist_km.i.)
within_erect_geo__ <- within_erect_geo_[-1]
row.names(within_erect_geo__) <- within_erect_geo_$within_erect_geo.d.pop2.i.
within_erect_geo_matrix <- as.matrix(within_erect_geo__)


#spearman

permu<-c()
for(i in 1:9999){
  permu[i]<-cor.test(as.vector(as.matrix(as.data.frame(within_erect_fst_matrix)[sample(1:dim(within_erect_fst_matrix)[1]),sample(1:dim(within_erect_fst_matrix)[2])])),as.vector(within_erect_geo_matrix),method=c("spearman"))$estimate
}

obs <- cor.test(as.vector(within_erect_fst_matrix),as.vector(within_erect_geo_matrix),method=c("spearman"))$estimate

(1+length(permu[permu>obs]))/10000

# rho = 0.4279839 (obs)
# pval = 0.0019




# within decumbent

within_dec_fst_ <- pivot_wider(data.frame(within_dec_fst$d.pop1.i., within_dec_fst$d.pop2.i., within_dec_fst$d.fst.i.), names_from = within_dec_fst.d.pop1.i., values_from = within_dec_fst.d.fst.i.)
within_dec_fst__ <- within_dec_fst_[-1]
row.names(within_dec_fst__) <- within_dec_fst_$within_dec_fst.d.pop2.i.
within_dec_fst_matrix <- as.matrix(within_dec_fst__)


within_dec_geo_ <- pivot_wider(data.frame(within_dec_geo$d.pop1.i., within_dec_geo$d.pop2.i., within_dec_geo$d.dist_km.i.), names_from = within_dec_geo.d.pop1.i., values_from = within_dec_geo.d.dist_km.i.)
within_dec_geo__ <- within_dec_geo_[-1]
row.names(within_dec_geo__) <- within_dec_geo_$within_dec_geo.d.pop2.i.
within_dec_geo_matrix <- as.matrix(within_dec_geo__)


#spearman

permu<-c()
for(i in 1:9999){
  permu[i]<-cor.test(as.vector(as.matrix(as.data.frame(within_dec_fst_matrix)[sample(1:dim(within_dec_fst_matrix)[1]),sample(1:dim(within_dec_fst_matrix)[2])])),as.vector(within_dec_geo_matrix),method=c("spearman"))$estimate
}

obs <- cor.test(as.vector(within_dec_fst_matrix),as.vector(within_dec_geo_matrix),method=c("spearman"))$estimate

(1+length(permu[permu>obs]))/10000

# rho = 0.8418172
# pval = 2e-04



# between erect and decumbent

between_ere_dec_fst_ <- pivot_wider(data.frame(between_ere_dec_fst$d.pop1.i., between_ere_dec_fst$d.pop2.i., between_ere_dec_fst$d.fst.i.), names_from = between_ere_dec_fst.d.pop1.i., values_from = between_ere_dec_fst.d.fst.i.)
between_ere_dec_fst__ <- between_ere_dec_fst_[-1]
row.names(between_ere_dec_fst__) <- between_ere_dec_fst_$between_ere_dec_fst.d.pop2.i.
between_ere_dec_fst_matrix <- as.matrix(between_ere_dec_fst__)

between_ere_dec_geo_ <- pivot_wider(data.frame(between_ere_dec_geo$d.pop1.i., between_ere_dec_geo$d.pop2.i., between_ere_dec_geo$d.dist_km.i.), names_from = between_ere_dec_geo.d.pop1.i., values_from = between_ere_dec_geo.d.dist_km.i.)
between_ere_dec_geo__ <- between_ere_dec_geo_[-1]
row.names(between_ere_dec_geo__) <- between_ere_dec_geo_$between_ere_dec_geo.d.pop2.i.
between_ere_dec_geo_matrix <- as.matrix(between_ere_dec_geo__)


# Spearman's test

permu<-c()
for(i in 1:9999){
  permu[i]<-cor.test(as.vector(as.matrix(as.data.frame(between_ere_dec_fst_matrix)[sample(1:dim(between_ere_dec_fst_matrix)[1]),sample(1:dim(between_ere_dec_fst_matrix)[2])])),as.vector(between_ere_dec_geo_matrix),method=c("spearman"))$estimate
}

obs <- cor.test(as.vector(between_ere_dec_fst_matrix),as.vector(between_ere_dec_geo_matrix),method=c("spearman"))$estimate

(1+length(permu[permu>obs]))/10000

# rho = 0.02619665
# pval = 0.4545


# plot
pdf("angusta_ibd.pdf", width = 6, height = 6)

plot(within_erect_fst_matrix ~ within_erect_geo_matrix, ylim=c(0,0.65), xlim=c(0,2000), col = "#EE442F", pch = 16, xlab = "Pairwise geographic distance (km)", ylab = expression("Pairwise F"[ST]))
points(within_dec_fst_matrix ~ within_dec_geo_matrix, pch=17, col = "#601A4A")
points(between_ere_dec_fst_matrix ~ between_ere_dec_geo_matrix, pch=3, col = "grey60")
legend("bottomright", bty = 'n', c(expression(paste("Within erect (",rho,"=0.43", ", ",italic("P"), "=0.0019)")), expression(paste("Within decumbent (",rho,"=0.84, ", italic("P"), "<0.001)")), expression(paste("Between erect and decumbent (",rho,"=0.026, ", italic("P"), "=0.45)"))),
       pch=c(16,17,3), col=c("#EE442F", "#601A4A", "grey60")
)


dev.off()

