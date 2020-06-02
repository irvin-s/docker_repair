FROM node:4-slim  
  
WORKDIR /usr/src/app  
  
ADD https://github.com/ewnchui/orgchart/archive/master.tar.gz /tmp  
  
RUN apt-get update && \  
apt-get -y install git && \  
apt-get clean && \  
cd /usr/src/app && \  
tar --strip-components=1 -xzf /tmp/master.tar.gz && \  
rm /tmp/master.tar.gz && \  
npm install bower coffee-script -g && \  
npm install && \  
bower install --allow-root  
  
EXPOSE 1337  
ENTRYPOINT ./entrypoint.sh

