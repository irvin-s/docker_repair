FROM node:latest  
MAINTAINER Marcel Sinn <loopyargon@gmail.com>  
  
RUN \  
apt-get update && \  
apt-get install -y \  
curl \  
git \  
ruby &&\  
rm -rf /var/lib/apt/lists/* && \  
git clone git://github.com/artemave/StarLogs.git && \  
cd /StarLogs/ && \  
gem install sass && \  
npm install -g \  
node-static \  
pogo  
  
EXPOSE 8080  
COPY start.sh /StarLogs/start.sh  
RUN chmod 774 /StarLogs/start.sh  
WORKDIR /StarLogs/  
CMD ["/StarLogs/start.sh"]  

