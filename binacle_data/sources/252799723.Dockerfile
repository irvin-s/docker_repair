FROM alpine:latest  
MAINTAINER dieKeuleCT<koehlmeier@gmail.com>  
RUN apk update && apk add subversion  
ADD startup.sh /usr/local/startup.sh  
RUN chmod +x /usr/local/startup.sh  
  
CMD "/usr/local/startup.sh"  

