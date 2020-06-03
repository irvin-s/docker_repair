FROM alpine:latest  
MAINTAINER Peter Mount <peter@retep.org>  
  
RUN apk add --update \  
firefox-esr \  
ttf-freefont \  
font-bitstream-75dpi \  
font-bitstream-100dpi \  
dbus &&\  
dbus-uuidgen >/etc/machine-id &&\  
rm -rf /var/cache/apk/*  
  
RUN addgroup -g 1000 user &&\  
adduser -h /home/user \  
-u 1000 \  
-G user \  
-s /bin/ash \  
-D user &&\  
echo "user:user" | chpasswd &&\  
mkdir -p /home/user &&\  
chown user:user /home/user  
USER user  
CMD ["firefox"]  
  
# Mount this to the same location to mount to the local X11 server  
VOLUME /tmp/.X11-unix  
  
# The user's home directory, mount to a volume to persist everything  
# i.e. browser history etc  
WORKDIR /home/user  
VOLUME /home/user  

