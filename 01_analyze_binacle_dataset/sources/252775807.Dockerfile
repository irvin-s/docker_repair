FROM golang:alpine3.7 AS build  
  
ARG CGO_ENABLED=0  
ARG GOOS=linux  
ARG GOARCH=amd64  
  
WORKDIR /usr/src/chaos-monkey  
COPY . /usr/src/chaos-monkey  
  
RUN apk add --no-cache git build-base  
RUN go get -d ./...  
RUN go build --ldflags="-s" .  
  
FROM scratch  
  
COPY \--from=build /usr/src/chaos-monkey/chaos-monkey /chaos-monkey  
  
ENTRYPOINT ["/chaos-monkey"]

