library(plyr)
setwd(dir = "C:/Users/rosha/Desktop/Oasis/Interval2/OriginalData")
clusterData<-read.csv("oasisTimeInterval2Posts.csv") # Done for each Interval for both companies
x <-clusterData[1]#X --> row number
y <-clusterData[10]#likes count
z <-clusterData[11]#comments count
a <-clusterData[12]#Shares count
#-----------------------------------------------------------------
data <- cbind(y,z,a) 
#normalization-----------------------------------------------
library(clusterSim)
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
library(factoextra)
set.seed(123)
gap_stat <- clusGap(dataNorm, FUN = kmeans, nstart = 25, K.max = 16, B = 50)#Compute gap statistic
print(gap_stat, method = "firstmax")# Print the result
plot(gap_stat, frame = FALSE, xlab = "Number of clusters k")# Base plot of gap statistic
fviz_gap_stat(gap_stat)#  output of clusGap() function can be visualized using the function fviz_gap_stat() [in factoextra]
#----------------------------------------------------------------------------------------
# K-Means Cluster Analysis--------------------------------------------------------------------
library(cluster)
library(animation)
km <- kmeans.ani(dataNorm,8 )
text(dataNorm, rownames(dataNorm))
View(km)
#--------------------------------------------------------------------------------------------
#get posts from clusters with maximum reach-------------------------------------------------
i<-1
df<-data.frame(from_id=numeric(),from_name=character(),message=character(),created_time=character(),likes_count=numeric(),comments_count=numeric(),id=numeric(),stringsAsFactors = FALSE)
while(i<=nrow(dataNorm))
{
  if(((dataNorm$likes_count[i]>=0.0)&&(dataNorm$comments_count[i]>=0.2))||(dataNorm$likes_count[i]>=0.7))
  {
    df<-rbind(df,clusterData[i,])
  }
  i<-i+1
}
View(df)
write.csv(df,"PostsOasisInterval2lol.csv")
#-----------------------------------------------------------------------------------------------
#get comments of posts with maximum reach-------------------------------------------------------
library("Rfacebook")
library("RCurl")
ouath<- fbOAuth(app_id = "266860267173578",app_secret = "43ff23acfe9a27f5073ef98c51c0967b")
#save n load oAuth----
save(ouath,file="ouath")
load("ouath")
setwd("C:/Users/rosha/Desktop/Oasis/Timeline/commentsOfPostswMaxReach")
ppost<-read.csv("commentsOasisTimeline.csv")
i<-1
df1<-data.frame(from_id=numeric(),from_name=character(),message=character(),created_time=character(),likes_count=numeric(),comments_count=numeric(),id=numeric(),stringsAsFactors = FALSE)
while(i<=nrow(df))
{
  postDet<-getPost(post=df$id[i],token=ouath,n=6000)[["comments"]]
  df1<-rbind(df1,postDet)
  i<-i+1
}
df2<-df1[3]
write.csv(df2[,1],"commentsOasisInterval2lol.txt")
#-------------------------------------------------------------------------------------------
