# build stage  
FROM golang:alpine AS build-env  
ADD . /src  
RUN cd /src && go build -o simple-web-server  
  
# final stage  
FROM alpine  
WORKDIR /app  
COPY \--from=build-env /src/simple-web-server /app/  
ENTRYPOINT ./simple-web-server

