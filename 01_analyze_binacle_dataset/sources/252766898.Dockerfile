FROM alpine:3.3  
MAINTAINER Alastair Montgomery "alastair@montgomery.me.uk"  
RUN apk --update add ympd  
  
EXPOSE 8080  
CMD ["ympd", "-h","mpdhost"]  

