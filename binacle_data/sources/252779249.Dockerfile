FROM golang:1.9-alpine3.6  
RUN apk add --no-cache git  
  
WORKDIR /go/src/app  
COPY . .  
  
RUN go-wrapper download  
RUN go-wrapper install  
  
CMD ["go-wrapper", "run"]  
EXPOSE 8080  

