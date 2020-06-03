FROM concourse/buildroot:base  
  
ADD check /opt/resource/  
ADD in /opt/resource/  
ADD out /opt/resource/  
RUN chmod +x /opt/resource/*  

