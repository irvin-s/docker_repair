FROM alpine  
MAINTAINER adirelle+docker@gmail.com  
  
RUN apk update && apk add clamav-daemon freshclam clamav-libunrar  
  
ADD *.conf /etc/clamav/  
  
RUN freshclam  
  
EXPOSE 7200  
CMD freshclam & exec clamd  

