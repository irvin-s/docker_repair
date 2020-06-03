FROM taskcluster/builder:0.5.9  
MAINTAINER Ronald Claveau <sousmangoosta@ovh.fr>  
  
# Add utilities and configuration  
ADD bin /home/worker/bin  
  
RUN yum install -y bc lzop  
RUN npm install -g bower gulp apm grunt-cli  
  
# Set a default command useful for debugging  
ENTRYPOINT ["build_it.sh"]  
  

