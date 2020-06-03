# Docker image with intravatar as entrypoint  
#  
# Note that the project is build on the container itself,  
# and that the build is not using the make file.  
FROM golang:1.8-alpine  
  
# build  
WORKDIR /go/src/intravatar  
COPY *.go ./  
  
RUN apk add --no-cache git \  
&& go get -v -d \  
&& go install -v \  
&& rm -rf /go/src /go/pkg \  
&& apk del --purge --no-cache git  
  
# run  
RUN mkdir /intravatar  
WORKDIR /intravatar  
COPY resources resources  
COPY config.ini .  
  
ENTRYPOINT ["intravatar"]  

