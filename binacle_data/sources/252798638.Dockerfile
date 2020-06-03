FROM alpine:latest  
MAINTAINER derflocki  
  
RUN apk update && apk add --no-cache ffmpegthumbnailer  
  
COPY mkthumbs /usr/local/bin/  
  
CMD ["mkthumbs"]  

