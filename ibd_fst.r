options(echo=TRUE)


setwd("C:/Users/evcur/Google Drive/Grass/angusta/ibd/alfreq")
## files in https://github.com/evcurran/Angusta-Pop-Genomics/tree/main/alfreq

# library to speed up loading of big tables
library(data.table)
library(stringr)

# function to calculate Hudson's Fst
# --------------------------------------------------
hudsonFst<-function(locus=NA, p1=NA, p2=NA){
  numerator<-p1 * (1 - p1) + p2 * (1 - p2)
  denominator<-p1 * (1 - p2) + p2 * (1 - p1)
  fst<-1 - numerator/denominator
  out<-data.frame(locus,numerator,denominator,fst)
  return(out)
}
# --------------------------------------------------

# function to calculate genome-wide Hudson's Fst
# --------------------------------------------------

GWhudsonsFst<-function(locus=NA, p1=NA, p2=NA){
  numerator<-p1 * (1 - p1) + p2 * (1 - p2)
  denominator<-p1 * (1 - p2) + p2 * (1 - p1)
  fst<-1 - numerator/denominator
  nloci<-length(na.exclude(fst))
  fst.mean<-1-((sum(numerator)/nloci)/(sum(denominator)/nloci))
  out<-data.frame(fst.mean)
  return(out)
}



pop_n <- read.csv("alfreq_files.txt", header = FALSE)

pop_pairs <- t(data.frame(combn(pop_n$V1, 2, simplify = FALSE)))
rownames(pop_pairs) <- c()


output <- NA

for(i in 1:nrow(pop_pairs)){
  pop1 <- pop_pairs[i,][1]
  pop2 <- pop_pairs[i,][2]
  p1 <- read.csv(paste(pop1,"_ibd.alfreq.txt", sep=""), header = FALSE, sep = " ")
  p2 <- read.csv(paste(pop2,"_ibd.alfreq.txt", sep=""), header = FALSE, sep = " ")
  fst.mean <- GWhudsonsFst(locus=p1$V1, p1=p1$V3, p2=p2$V3)
  line <- data.frame(pop1, pop2, fst.mean$fst.mean)
  output <- rbind(output, line)
                
  
}


write.csv(output, file="ibd.pairwiseFst.csv", 
            quote=F, row.names=F)






