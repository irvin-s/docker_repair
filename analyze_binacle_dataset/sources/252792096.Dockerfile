FROM golang:1.10  
RUN go get github.com/chasekaylee/gawkbox-mobile  
  
WORKDIR /go/src/gawkbox-mobile  
  
COPY . .  
  
RUN go build  
  
CMD ["gawkbox-mobile"]  
  
# Document that the service listens on port 8080.  
EXPOSE 8080  
#docker build -t sample .  
#docker run -p 8080:8080 sample

