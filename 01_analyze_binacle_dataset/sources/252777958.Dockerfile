FROM golang:alpine3.6 AS binary  
ADD . /app  
WORKDIR /app  
RUN apk update && \  
apk upgrade && \  
apk add git  
RUN go get github.com/apk/httptools  
RUN CGO_ENABLED=0 go build -o gnord  
  
FROM scratch  
MAINTAINER Andreas Krey <a.krey@gmx.de>  
  
WORKDIR /html  
  
COPY \--from=binary /app/gnord /gnord  
  
EXPOSE 80  
VOLUME ["/html"]  
CMD ["/gnord","--ip","80"]  

