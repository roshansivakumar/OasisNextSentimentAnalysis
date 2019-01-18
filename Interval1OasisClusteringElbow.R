library(plyr)
setwd(dir = "C:/Users/rosha/Desktop/Oasis/Interval1")
clusterData<-read.csv("oasisTimeInterval1Posts.csv")
x <-clusterData[1]#X --> row number
y <-clusterData[10]#likes count
z <-clusterData[11]#comments count
#likes+comments stored in CplusL  --------------------------------------------------------------
CplusL<-data.frame(Y=numeric())#defining empty data frame 
j<-1
while(j<=nrow(clusterData))
{
  CplusL[j,1]<-y[j,1]+z[j,1]
  j<-j+1
}
#------------------------------------------------------------
data <- cbind(x,CplusL) 
#normalization-----------------------------------------------
dataNorm<-data.Normalization(data,type="n4",normalization = "column")
#--------------------------------------------------------------
plot(dataNorm,main="original Dataset")
#Elbow Method-Scree plot to deterine the number of clusters-----
wss <- (nrow(dataNorm)-1)*sum(apply(dataNorm,2,var))
for (i in 2:15) {
  wss[i] <- sum(kmeans(dataNorm,centers=i)$withinss)
}   
plot(1:15, wss, type="b", xlab="Number of Clusters",ylab="WSS(~cost function)")
#--------------------------------------------------------------
#Silhouette analysis for determining the number of clusters----
library(fpc)
asw <- numeric(20)
for (k in 2:20)
  asw[[k]] <- pam(dataNorm, k) $ silinfo $ avg.width
k.best <- which.max(asw)
cat("silhouette-optimal number of clusters:", k.best, "\n")
plot(pam(dataNorm, k.best))
#----------------------------------------------------------------
#Gap statistic method  for determining the number of clusters----
set.seed(123)
gap_stat <- clusGap(dataNorm, FUN = kmeans, nstart = 25, K.max = 10, B = 50)#Compute gap statistic
print(gap_stat, method = "firstmax")# Print the result
plot(gap_stat, frame = FALSE, xlab = "Number of clusters k")# Base plot of gap statistic
fviz_gap_stat(gap_stat)#  output of clusGap() function can be visualized using the function fviz_gap_stat() [in factoextra]
#------------------------------------------------------------------
# K-Means Cluster Analysis
km <- kmeans.ani(dataNorm, 2)
text(dataNorm, rownames(dataNorm))
#-----------------------------------------------------------------
  