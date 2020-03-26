FROM alpine:3.7  
MAINTAINER e.a.agafonov@gmail.com  
  
RUN apk add --no-cache \  
openssh \  
bash \  
git \  
curl  
  
RUN adduser -D safeuser -s /bin/bash  
  
ADD entrypoint.sh /  
  
USER safeuser  
RUN mkdir -p /home/safeuser/.ssh  
  
ENV SSH_KEY_DEPLOYER ''  
ENV SSH_STRICT_HOST_KEY_CHECKING yes  
  
ENTRYPOINT /entrypoint.sh  

