FROM carlosotgz/cuckoo:2.0.4a1  
  
LABEL maintainer "Carlos Ortigoza Dempster"  
  
RUN apk add --no-cache openssh-client  
  
# Wrapper and tweaks for VirtualBox outside of the container  
COPY wrapper.sh /wrapper.sh  
COPY virtualbox_tweaks.py /virtualbox_tweaks.py  
  
COPY docker-entrypoint.sh /entrypoint.sh  
  
ENTRYPOINT ["/entrypoint.sh"]  
CMD ["--help"]  

