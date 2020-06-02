# build stage  
FROM golang:alpine AS build-env  
RUN apk update; apk add git  
RUN go get -u github.com/golang/dep/cmd/dep  
ENV PROJECT_DIR ${HOME}/go/src/github.com/bat-cha/foxtender  
ADD . ${PROJECT_DIR}  
RUN cd ${PROJECT_DIR} && dep ensure && go build -o foxtender  
  
# final stage  
FROM alpine  
ENV PROJECT_DIR ${HOME}/go/src/github.com/bat-cha/foxtender  
LABEL maintainer="bat-cha <baptiste.chatrain@gmail.com>"  
WORKDIR /app  
RUN apk update \  
&& apk upgrade \  
&& apk add \--no-cache \  
ca-certificates \  
&& update-ca-certificates 2>/dev/null || true  
COPY \--from=build-env ${PROJECT_DIR}/foxtender /app/  
ENTRYPOINT ./foxtender

