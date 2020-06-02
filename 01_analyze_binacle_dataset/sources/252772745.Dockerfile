FROM alpine:3.6  
LABEL maintainer "Benjamin Stein <info@diffus.org>"  
ENV GPG_TTY /dev/console  
RUN \  
apk add --no-cache \  
make \  
git \  
bash \  
openssh \  
tree \  
gnupg && \  
git clone https://git.zx2c4.com/password-store /root/password-store && \  
make --directory /root/password-store install && \  
rm -rf /root/password-store  
ENTRYPOINT ["/usr/bin/pass"]  

