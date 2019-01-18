library("Rfacebook")
library("RCurl")
ouath<- fbOAuth(app_id = "266860267173578",app_secret = "43ff23acfe9a27f5073ef98c51c0967b")
#save n load oAuth----
 save(ouath,file="ouath")
 load("ouath")
#---------------------
getpagedata<-getPage(page = 94971738769,token =ouath,since ='2016/11/08' ,until ='2017/02/08',n=5000)
View(getpagedata)
setwd("C:/Users/rosha/Desktop/nextTimeline")
imppost<-read.csv("CommentsNextTimeline.csv")
write.csv(imppost,"CommentsNextTimeline.txt")
setwd("C:/Users/rosha/Desktop")
imppost1<-read.csv("clusno1Posts.csv")
i<-1
df<-data.frame(from_id=numeric(),from_name=character(),message=character(),created_time=character(),likes_count=numeric(),comments_count=numeric(),id=numeric(),stringsAsFactors = FALSE)
while(i<=nrow(imppost))
{
  postDet<-getPost(post=imppost$id[i],token=ouath,n=6000)[["comments"]]
  df<-rbind(df,postDet)
  i<-i+1
}
View(df)#comments
View(dfr)#likes and reactions