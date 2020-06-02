FROM node:8.1.0-slim  
  
RUN \  
# install build tools  
echo '[1] apt-get update' && \  
apt-get -qq update && \  
echo '[2] apt-get install' && \  
apt-get -qq install -y \  
make \  
gcc \  
g++ \  
python && \  
# app root path  
mkdir -p /srv/app && \  
# download repo and extract to /tmp  
echo '[3] download repo' && \  
wget -P /tmp -q https://github.com/amokrushin/duk/archive/master.tar.gz && \  
echo '[4] extract repo' && \  
tar -xzf /tmp/master.tar.gz -C /tmp && \  
# move service from repo to /srv/app  
mv /tmp/duk-master/services/image-transform/* /srv/app && \  
# move shared from repo to /srv/shared  
mv /tmp/duk-master/shared/ /srv/shared && \  
# install shared deps and link it  
echo '[5] init shared' && \  
cd /srv/shared/duk-task-queue/ && \  
yarn install --production && \  
yarn link && \  
# install service deps and link shared  
echo '[6] init service' && \  
cd /srv/app && \  
yarn install --production && \  
yarn link duk-task-queue && \  
# cleanup  
echo '[7] cleanup' && \  
yarn cache clean && \  
apt-get remove --purge -y \  
make \  
gcc \  
g++ \  
python && \  
apt-get autoremove -y && \  
rm -rf \  
/var/lib/apt/lists/* \  
/tmp/*  
  
WORKDIR /srv/app  
  
CMD ["node", "app.js"]  

