FROM alpine:latest  
  
MAINTAINER Brad Wadsworth  
  
RUN apk --no-cache upgrade && \  
apk --no-cache add alpine-sdk && \  
adduser -D packager && \  
addgroup packager abuild && \  
echo 'packager ALL=(ALL:ALL) NOPASSWD:ALL' > /etc/sudoers.d/packager && \  
chmod 640 /etc/sudoers.d/packager && \  
mkdir -p /var/cache/distfiles && \  
chmod a+w /var/cache/distfiles  
  
USER packager  
WORKDIR /home/packager  
  
CMD /bin/sh  

