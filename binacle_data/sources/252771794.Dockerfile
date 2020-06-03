FROM atijust/golang:1.8.3-alpine AS build  
RUN go get gopkg.in/mattes/migrate.v1  
RUN go get github.com/maxcnunes/waitforit  
  
FROM alpine:3.5  
COPY \--from=build /go/bin/migrate.v1 /usr/local/bin/migrate  
COPY \--from=build /go/bin/waitforit /usr/local/bin/waitforit  
RUN mkdir /migrations  
WORKDIR /migrations  
COPY docker-entrypoint.sh /usr/local/bin/  
ENTRYPOINT ["docker-entrypoint.sh"]

