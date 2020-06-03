FROM node  
  
RUN apt-get update && \  
apt-get install -y git jq  
  
COPY install_pm.sh ./  
  
RUN chmod +x ./install_pm.sh  
RUN ./install_pm.sh  

