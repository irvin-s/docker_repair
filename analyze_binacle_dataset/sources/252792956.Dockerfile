FROM golang:1.8-alpine  
LABEL maintainer="Eric Chang <chiahan1123@gmail.com>"  
  
RUN apk update && apk upgrade && \  
apk add --no-cache bash git openssh && \  
rm -rf /var/cache/apk/*  
  
COPY coverageTools.sh /coverageTools.sh  
RUN /coverageTools.sh && \  
rm /coverageTools.sh  
  

