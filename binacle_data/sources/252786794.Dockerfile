FROM gliderlabs/alpine  
MAINTAINER Nils Rocine <nils@bountyapp.co>  
  
RUN apk --update add ca-certificates  
RUN apk add tzdata  

