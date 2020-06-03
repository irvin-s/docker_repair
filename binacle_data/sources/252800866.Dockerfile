FROM golang:1.10-alpine AS build-env  
# package dependencies  
RUN apk add --update --no-cache make git libc-dev  
  
# install dependency tool  
RUN go get -u github.com/golang/dep/cmd/dep  
  
WORKDIR /go/src/github.com/dotzero/pad  
  
COPY . .  
  
# build  
RUN dep ensure -v \  
&& make build \  
&& /go/bin/pad --version  
  
FROM alpine:3.7  
WORKDIR /app  
  
# copy artefacts  
COPY \--from=build-env /go/bin/pad /app  
COPY \--from=build-env /go/src/github.com/dotzero/pad/web/ /app/web/  
  
ENV PAD_DB_PATH "./db"  
ENV PAD_SECRET "true_random_salt"  
ENV PAD_HOST "0.0.0.0"  
ENV PAD_PORT "8080"  
EXPOSE ${PAD_PORT}  
  
ENTRYPOINT ["/app/pad"]  

