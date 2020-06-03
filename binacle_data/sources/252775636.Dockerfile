FROM instrumentisto/glide:latest  
WORKDIR /go/src/  
RUN mkdir github.com && cd github.com \  
&& git clone https://github.com/blee1170/LED-Control.git \  
&& cd LED-Control && glide install \  
&& GOOS=linux GOARCH=amd64 go build  
  
FROM golang:1.10-alpine  
RUN mkdir /go/html && mkdir /go/images  
COPY \--from=0 /go/src/github.com/LED-Control/html/* /go/html/  
COPY \--from=0 /go/src/github.com/LED-Control/images/* /go/images/  
COPY \--from=0 /go/src/github.com/LED-Control/LED-Control .  
CMD ["./LED-Control"]  

