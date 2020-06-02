FROM golang:1.8.3-alpine3.6  
MAINTAINER Siddhartha Basu<siddhartha-basu@northwestern.edu>  
  
RUN apk add --no-cache git  
WORKDIR /go/src/app  
COPY . /go/src/app  
RUN go-wrapper download \  
&& go-wrapper install  
  
CMD ["go-wrapper", "run"]  
EXPOSE 9995  
ENV TZ America/Chicago  

