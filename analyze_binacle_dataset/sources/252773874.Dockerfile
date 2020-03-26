FROM debian:jessie  
  
LABEL maintainer="docker@alphahydrae.com"  
  
ADD https://dl.eff.org/certbot-auto /usr/local/bin/certbot-auto  
  
RUN chmod +x /usr/local/bin/certbot-auto  
  
RUN /usr/local/bin/certbot-auto --non-interactive --os-packages-only  
  
CMD [ "/bin/bash" ]  

