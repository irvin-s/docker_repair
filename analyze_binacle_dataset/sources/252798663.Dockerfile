FROM ubuntu:17.04  
MAINTAINER matthes@leuffen.de  
  
ADD .docker/install.sh /root/install.sh  
RUN /root/install.sh  
  
Add .docker/config.sh /root/config.sh  
RUN /root/config.sh  
  
ADD .docker/loop.sh /root/loop.sh  
  
ADD golafix /golafix  
ADD opt /opt  
  
ADD .docker/post-install.sh /root/post-install.sh  
RUN /root/post-install.sh  
  
EXPOSE 80  
ENTRYPOINT ["/root/loop.sh"]

