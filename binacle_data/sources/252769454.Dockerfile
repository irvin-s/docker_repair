# Build Caddy  
FROM golang:1.10  
RUN go get github.com/mholt/caddy/caddy  
RUN go get github.com/caddyserver/builds  
WORKDIR /go/src/github.com/mholt/caddy/caddy  
RUN go run build.go  
  
# Create main container  
FROM alpine:3.6  
ADD site /home/site  
ADD caddy/live.conf /etc/caddy/live.conf  
COPY \--from=0 /go/src/github.com/mholt/caddy/caddy/caddy /usr/bin/caddy  
RUN chmod 0755 /usr/bin/caddy  
  
EXPOSE 80  
ENTRYPOINT /usr/bin/caddy --conf /etc/caddy/live.conf  

