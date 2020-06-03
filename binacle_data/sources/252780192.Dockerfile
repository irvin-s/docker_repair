FROM golang:1.8-alpine  
  
# We want to ensure that release builds never have any cgo dependencies so we  
# switch that off at the highest level.  
ENV CGO_ENABLED 0  
  
RUN apk update && apk upgrade && \  
apk add \--no-cache alpine-sdk bash openssh openssh-client zip  

