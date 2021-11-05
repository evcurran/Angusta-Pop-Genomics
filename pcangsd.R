
setwd("C:/Users/evcur/Google Drive/Grass/angusta/pca/from_beagle")

# Read input file
covar <- read.table("angusta.cov", stringsAsFact=F);

# Parse components to analyze
comp <- as.numeric(strsplit("1-2", "-", fixed=TRUE)[[1]])

# Eigenvalues
eig <- eigen(covar, symm=TRUE);
eig$val <- eig$val/sum(eig$val);
cat(signif(eig$val, digits=3)*100,"/n");

eigv <- signif(eig$val, digits=3)*100

# view distribution of eigenvectors
eig_plot <- barplot(eigv, ylab="Percentage of variance", xlab="Eigenvector")

PC <- as.data.frame(eig$vectors)
PCs <- data.frame(PC$V1, PC$V2, PC$V3, PC$V4)

plot(PCs$PC.V1, PCs$PC.V2)
