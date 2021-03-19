setwd("C:/Users/evcur/Google Drive/Grass/angusta/pca/morpho")

# read in data
data<-read.csv('pca_morph_data.csv',header=T)
attach(data)

# perform principal components analysis on morphological measurements
pcares<-prcomp(data[,3:11],center=T,scale=T)

# Proportion of variance explained by each principal component
summary(pcares)


# extract first two principal components
data$PC1 <- pcares$x[,1]
data$PC2 <- pcares$x[,2]


# generate plot

pdf("pca_morph_zambia.pdf", height=6, width=6, useDingbats=F)
par(mar=c(4.5,4.5,2,1.5))

plot(data$PC1, data$PC2, col=as.character(data$col), pch=data$pch, xlab = "PC1 (42.18%)", ylab = "PC2 (19.29%)", cex.axis=1.3, cex.lab=1.3)
legend("bottomright", legend=c(expression(paste(italic("A. angusta"), " - decumbent")), expression(paste(italic("A. angusta"), " - erect")), expression(paste(italic("A. semialata")))), 
       col = c("#601A4A", "#EE442F", "#63ACBE"), pch = c(17,16,16))

# circle individuals which also have sequencing data
points(data[data$sequenced=="Y",]$PC1, data[data$sequenced=="Y",]$PC2, pch = 1, cex = 1.5, col = "grey60")

# add arrows to indicate variable loadings
l.x <- pcares$rotation[,1]*5
l.y <- pcares$rotation[,2]*5
arrows(x0=0, x1=l.x, y0=0, y1=l.y, length=0.15, lwd=1.5)

# Label position
l.pos <- l.y # Create a vector of y axis coordinates
lo <- which(l.y < 0) # Get the variables on the bottom half of the plot
hi <- which(l.y > 0) # Get variables on the top half
# Replace values in the vector
l.pos <- replace(l.pos, lo, "1")
l.pos <- replace(l.pos, hi, "3")
l.labs <- a<-gsub(".", " ", row.names(pcares$rotation), fixed=TRUE)
text(l.x, l.y, labels=l.labs, pos=l.pos, cex = 0.6)


dev.off()


