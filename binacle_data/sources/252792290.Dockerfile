FROM dancinllama/dockerdx  
RUN git clone https://github.com/wadewegner/sfdx-waw-plugin.git && \  
apt-get update && \  
apt-get install -yq curl && \  
curl -sL https://deb.nodesource.com/setup_6.x | bash - && \  
apt-get install -yq nodejs build-essential && \  
cd sfdx-waw-plugin && \  
npm install && \  
sfdx plugins:link . && \  
sfdx plugins:install sfdx-waw-plugin && \  
cd ..  
  

