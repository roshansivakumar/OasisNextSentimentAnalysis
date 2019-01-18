library("Rfacebook")
library("RCurl")
ouath<- fbOAuth(app_id = "266860267173578",app_secret = "43ff23acfe9a27f5073ef98c51c0967b")
#save n load oAuth 
save(ouath,file="ouath")
load("ouath")
#me<-getUsers("me",token=ouath)
getpagedata1<-getPage(page = 32075534692,token =ouath,since ='2016/11/08' ,until ='2017/11/08',n=5000)
View(getpagedata1)
df1<-data.frame(from_id=numeric(),from_name=character(),message=character(),created_time=character(),likes_count=numeric(),comments_count=numeric(),id=numeric(),stringsAsFactors = FALSE)
i<-1
while(i<=nrow(getpagedata1))
{
  postDet1<-getPost(post=getpagedata1$id[i],token=ouath,n=6000)[["comments"]]
  df1<-rbind(df1,postDet1)
  i<-i+1
}
View(df1)
#View(df[-4:-6])#remove like,comment count