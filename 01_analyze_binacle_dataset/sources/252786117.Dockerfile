#Dockerfile  
FROM golang:1.6-alpine  
MAINTAINER David Malone <avidmalone@gmail.com>  
  
RUN apk add --update \  
git \  
&& rm -rf /var/cache/apk/*  
  
ENV AWS_ENDPOINT awsendpoint  
ENV AWS_ACCESS_KEY_ID awsaccesskeyid  
ENV AWS_SECRET_ACCESS_KEY awssecretaccesskey  
ENV EMAIL_TEMPLATE_DIR ./  
ENV FB_APP_ID fbappid  
ENV FB_APP_SECRET fbappsecret  
ENV MONGO_URL mongourl  
  
RUN git clone https://github.com/spear-wind/cms /go/src/spear-wind/cms  
RUN ls /go/src/spear-wind/cms  
WORKDIR /go/src/spear-wind/cms  
RUN go get \  
&& go build  
RUN mv /go/src/spear-wind/cms/cms /app  
RUN rm -rf /go/src/spear-wind  
  
EXPOSE 3000  
ENTRYPOINT /app  

