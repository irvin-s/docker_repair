FROM alpine  
  
MAINTAINER Alvaro Gonzalez <Alvaro.Gonzalez@cern.ch>  
  
RUN apk update && \  
apk upgrade && \  
apk add git  

