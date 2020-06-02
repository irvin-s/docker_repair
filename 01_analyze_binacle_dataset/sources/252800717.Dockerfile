FROM golang:1.9-alpine3.6  
MAINTAINER Alexey Kovrizhkin <lekovr+dopos@gmail.com>  
  
ENV TRAEFIKFL_VERSION 0.1  
WORKDIR /go/src/github.com/dopos/traefik-fl  
COPY . .  
  
RUN go-wrapper download  
RUN CGO_ENABLED=0 GOOS=linux go build -a -o traefik-fl  
  
FROM scratch  
  
WORKDIR /  
COPY \--from=0 /go/src/github.com/dopos/traefik-fl/traefik-fl .  
  
EXPOSE 8080  
ENTRYPOINT ["/traefik-fl"]  
  

