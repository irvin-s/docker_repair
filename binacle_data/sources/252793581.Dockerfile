FROM concourse/docker-image-resource  
  
#ADD docker/ /usr/local/bin/  
#RUN /usr/local/bin/docker --version  
ADD assets/ /opt/resource/  
RUN chmod +x /opt/resource/*  
  
#ADD bin/ /bin/  

