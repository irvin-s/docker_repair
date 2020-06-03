FROM gliderlabs/alpine:latest  
  
RUN apk-install \  
bash \  
bind \  
bind-tools \  
openssh-client \  
git \  
rsync  
  
ADD *.sh /usr/local/bin/  
ADD rsyncignore /etc/  
  
WORKDIR /zones  

