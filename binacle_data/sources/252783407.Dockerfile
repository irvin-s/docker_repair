FROM golang:alpine  
  
MAINTAINER Dean Sheather <dean@deansheather.com>  
  
RUN mkdir /app  
ADD . /app/  
WORKDIR /app  
  
RUN apk update && apk add git  
RUN go get github.com/satori/go.uuid  
RUN go get github.com/Sirupsen/logrus  
RUN go get gopkg.in/kataras/iris.v6  
RUN go get gopkg.in/olivere/elastic.v5  
  
RUN go build -o cloudbleed-search-api cloudbleed-search-api.go  
  
EXPOSE 8080  
CMD ["/app/cloudbleed-search-api"]  

