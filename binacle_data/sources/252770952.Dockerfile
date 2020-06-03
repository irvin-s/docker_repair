FROM gliderlabs/alpine:latest  
  
RUN apk --update add tar wget ca-certificates  
  
ENV VERSION 1.13  
ENV APP HeavyThing-$VERSION  
  
RUN wget https://2ton.com.au/$APP.tar.gz  
RUN tar zxvf $APP.tar.gz  
WORKDIR $APP  
  
CMD hnwatch/hnwatch  

