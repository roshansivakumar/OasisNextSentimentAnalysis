library("Rfacebook")
library("RCurl")
ouath<- fbOAuth(app_id = "266860267173578",app_secret = "43ff23acfe9a27f5073ef98c51c0967b")
#save n load oAuth----
 save(ouath,file="ouath")
 load("ouath")
#---------------------
getpagedata<-getPage(page = 94971738769,token =ouath,since ='2016/11/08' ,until ='2017/11/08',n=5000)#to get comments/post/reactions for Oasis company change the pageID
View(getpagedata)
df<-data.frame(from_id=numeric(),from_name=character(),message=character(),created_time=character(),likes_count=numeric(),comments_count=numeric(),id=numeric(),stringsAsFactors = FALSE)
dfr<-data.frame(id=numeric(),likes_count=numeric(),love_count=numeric(),haha_count=numeric(),wow_count=numeric(),sad_count=numeric(),angry_count=numeric())
i<-1
while(i<=nrow(getpagedata))
{
  postDet<-getPost(post=getpagedata$id[i],token=ouath,n=6000)[["comments"]]
  df<-rbind(df,postDet)
  getreaction <- getReactions(post=getpagedata$id[i], token=ouath)
  dfr<-rbind(dfr,getreaction)
  i<-i+1
}
View(df)#comments
View(dfr)#likes and reactions
