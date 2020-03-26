FROM alpine:3.7  
LABEL maintainer="beudbeud@beudibox.fr"  
  
RUN apk update && apk add build-base python3 python3-dev graphicsmagick ffmpeg  
  
RUN pip3 install prosopopee==0.8.1  
  
RUN mkdir /site  
  
WORKDIR /site  
  
RUN apk del python3-dev build-base  
  
ENTRYPOINT ["prosopopee"]  
  
EXPOSE 9000  

