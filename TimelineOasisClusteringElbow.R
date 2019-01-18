library(plyr)
setwd(dir = "C:/Users/rosha/Desktop/Oasis/Timeline")
clusterData<-read.csv("oasisTimelinePosts.csv")
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
for (i in 2:20) {
  wss[i] <- sum(kmeans(dataNorm,centers=i)$withinss)
}   
plot(1:20, wss, type="b", xlab="Number of Clusters",ylab="WSS(~cost function)")
#--------------------------------------------------------------
# K-Means Cluster Analysis
km <- kmeans.ani(dataNorm, 6)
text(dataNorm, rownames(dataNorm))
#-----------------------------------------------------------------