FROM cravler/faye-app  
  
LABEL maintainer "Sergei Vizel <http://github.com/cravler>"  
  
RUN \  
  
# Install dependencies  
apt-get update && apt-get install -y --no-install-recommends \  
rsync && \  
  
# Remove cache  
apt-get clean && rm -rf /var/lib/apt/lists/* && \  
# Build Faye  
git clone https://github.com/cravler/faye /faye && \  
cd /faye && \  
git checkout patch-1 && \  
npm i && \  
make && \  
  
# Install Faye  
cd /usr/local/lib/node_modules/faye-app && \  
rm -rf node_modules && \  
npm i -S /faye/build && \  
npm i && \  
sed -i 's/"version": "0.*"/"version": "dev"/g' package.json  

