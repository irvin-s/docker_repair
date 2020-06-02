FROM akretion/voodoo  
  
USER root  
  
RUN DEBIAN_FRONTEND=noninteractive && \  
apt-get update && \  
apt-get install -y cups libcups2-dev && \  
apt-get clean  
  
USER developer  

