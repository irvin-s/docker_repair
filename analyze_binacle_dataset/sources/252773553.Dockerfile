FROM digitallyseamless/nodejs-bower-grunt  
  
RUN apt-get update && \  
apt-get install -y python-pip && \  
pip install sphinx && \  
apt-get clean && rm -rf /var/lib/apt/lists/* && rm -rf /var/tmp/*  

