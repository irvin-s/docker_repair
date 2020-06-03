FROM node:wheezy  
  
RUN apt-get update -q && \  
apt-get upgrade -qy && \  
apt-get install -qy build-essential && \  
apt-get install -qy libpng-dev && \  
apt-get install -qy python-minimal && \  
apt-get install -qy git wget && \  
apt-get clean  
  
ADD ["http://download.redis.io/redis-stable.tar.gz", "/redis-stable.tar.gz"]  
  
RUN tar xvzf redis-stable.tar.gz && \  
cd redis-stable && \  
make && \  
cp src/redis-server /usr/bin/ && \  
cp src/redis-cli /usr/bin/  
  
RUN cd /var/lib && \  
git clone -b stable http://github.com/vatesfr/xo-server && \  
git clone -b stable http://github.com/vatesfr/xo-web  
  
RUN cd /var/lib/xo-server && \  
npm install && \  
npm run build && \  
cp sample.config.yaml .xo-server.yaml  
  
ADD xo-server.yaml /var/lib/xo-server/.xo-server.yaml  
  
RUN cd /var/lib/xo-web && \  
npm install && \  
npm run build  
  
RUN npm install -g forever  
  
RUN mkdir /etc/redis && \  
mkdir /var/redis && \  
mkdir /var/redis/6379  
  
ADD redis_init_script /etc/init.d/redis_6379  
  
RUN chmod +x /etc/init.d/redis_6379  
  
ADD 6379.conf /etc/redis/6379.conf  
  
RUN update-rc.d redis_6379 defaults  
  
ADD launch.sh /launch.sh  
  
RUN chmod +x "/launch.sh"  
  
EXPOSE 80  
CMD ["/launch.sh"]  

