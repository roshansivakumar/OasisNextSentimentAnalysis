library("Rfacebook")
library("RCurl")
ouath<- fbOAuth(app_id = "266860267173578",app_secret = "43ff23acfe9a27f5073ef98c51c0967b")
#save n load oAuth----
save(ouath,file="ouath")
load("ouath")
#---------------------
getpagedata<-getPage(page = 94971738769,token =ouath,since ='2016/11/08' ,until ='2017/11/08',n=5000)
getpagedata1<-getPage(page = 94971738769,token =ouath,since ='2016/11/08' ,until ='2017/02/08',n=5000)
getpagedata2<-getPage(page = 94971738769,token =ouath,since ='2017/02/08' ,until ='2017/05/08',n=5000)
getpagedata3<-getPage(page = 94971738769,token =ouath,since ='2017/05/08' ,until ='2017/08/08',n=5000)
getpagedata4<-getPage(page = 94971738769,token =ouath,since ='2017/08/08' ,until ='2017/11/08',n=5000)
View(getpagedata)
View(getpagedata1)
View(getpagedata2)
View(getpagedata3)
View(getpagedata4)
df<-data.frame(from_id=numeric(),from_name=character(),message=character(),created_time=character(),likes_count=numeric(),comments_count=numeric(),id=numeric(),stringsAsFactors = FALSE)
dfr<-data.frame(id=numeric(),likes_count=numeric(),love_count=numeric(),haha_count=numeric(),wow_count=numeric(),sad_count=numeric(),angry_count=numeric())
df1<-data.frame(from_id=numeric(),from_name=character(),message=character(),created_time=character(),likes_count=numeric(),comments_count=numeric(),id=numeric(),stringsAsFactors = FALSE)
dfr1<-data.frame(id=numeric(),likes_count=numeric(),love_count=numeric(),haha_count=numeric(),wow_count=numeric(),sad_count=numeric(),angry_count=numeric())
df2<-data.frame(from_id=numeric(),from_name=character(),message=character(),created_time=character(),likes_count=numeric(),comments_count=numeric(),id=numeric(),stringsAsFactors = FALSE)
dfr2<-data.frame(id=numeric(),likes_count=numeric(),love_count=numeric(),haha_count=numeric(),wow_count=numeric(),sad_count=numeric(),angry_count=numeric())
df3<-data.frame(from_id=numeric(),from_name=character(),message=character(),created_time=character(),likes_count=numeric(),comments_count=numeric(),id=numeric(),stringsAsFactors = FALSE)
dfr3<-data.frame(id=numeric(),likes_count=numeric(),love_count=numeric(),haha_count=numeric(),wow_count=numeric(),sad_count=numeric(),angry_count=numeric())
df4<-data.frame(from_id=numeric(),from_name=character(),message=character(),created_time=character(),likes_count=numeric(),comments_count=numeric(),id=numeric(),stringsAsFactors = FALSE)
dfr4<-data.frame(id=numeric(),likes_count=numeric(),love_count=numeric(),haha_count=numeric(),wow_count=numeric(),sad_count=numeric(),angry_count=numeric())
i<-1
while(i<=nrow(getpagedata))
{
  postDet<-getPost(post=getpagedata$id[i],token=ouath,n=6000)[["comments"]]
  df<-rbind(df,postDet)
  getreaction <- getReactions(post=getpagedata$id[i], token=ouath)
  dfr<-rbind(dfr,getreaction)
  i<-i+1
}
j<-1
while(j<=nrow(getpagedata1))
{
  postDet1<-getPost(post=getpagedata1$id[j],token=ouath,n=6000)[["comments"]]
  df1<-rbind(df1,postDet1)
  getreaction1 <- getReactions(post=getpagedata$id[j], token=ouath)
  dfr1<-rbind(dfr1,getreaction1)
  j<-j+1
}
k<-1
while(k<=nrow(getpagedata2))
{
  postDet2<-getPost(post=getpagedata2$id[k],token=ouath,n=6000)[["comments"]]
  df2<-rbind(df2,postDet2)
  getreaction2 <- getReactions(post=getpagedata2$id[k], token=ouath)
  dfr2<-rbind(dfr2,getreaction2)
  k<-k+1
}
l<-1
while(l<=nrow(getpagedata3))
{
  postDet3<-getPost(post=getpagedata3$id[l],token=ouath,n=6000)[["comments"]]
  df3<-rbind(df3,postDet3)
  getreaction3 <- getReactions(post=getpagedata3$id[l], token=ouath)
  dfr3<-rbind(dfr3,getreaction3)
  l<-l+1
}
m<-1
while(m<=nrow(getpagedata4))
{
  postDet4<-getPost(post=getpagedata4$id[m],token=ouath,n=6000)[["comments"]]
  df4<-rbind(df4,postDet4)
  getreaction4 <- getReactions(post=getpagedata4$id[m], token=ouath)
  dfr4<-rbind(dfr4,getreaction4)
  m<-m+1
}
View(df)#comments
View(dfr)#likes and reactions
View(df1)#comments
View(dfr1)#likes and reactions
View(df2)#comments
View(dfr2)#likes and reactions
View(df3)#comments
View(dfr3)#likes and reactions
View(df4)#comments
View(dfr4)#likes and reaction