#  
# Redis Dockerfile  
#  
# https://github.com/dockerfile/redis  
#  
# Pull base image.  
FROM debian:jessie  
RUN apt-get install wget -y -q  
# Install Redis.  
RUN \  
cd /tmp && \  
wget https://github.com/antirez/redis/archive/3.2.0-rc3.tar.gz && \  
tar xvzf redis-stable.tar.gz redis-stable && \  
cd redis-stable && \  
make && \  
make install && \  
cp -f src/redis-sentinel /usr/local/bin && \  
mkdir -p /etc/redis && \  
cp -f *.conf /etc/redis && \  
rm -rf /tmp/redis-stable* && \  
sed -i 's/^\\(bind .*\\)$/# \1/' /etc/redis/redis.conf && \  
sed -i 's/^\\(daemonize .*\\)$/# \1/' /etc/redis/redis.conf && \  
sed -i 's/^\\(dir .*\\)$/# \1\ndir \/data/' /etc/redis/redis.conf && \  
sed -i 's/^\\(logfile .*\\)$/# \1/' /etc/redis/redis.conf  
  
# Define mountable directories.  
VOLUME ["/data"]  
  
# Define working directory.  
WORKDIR /data  
  
# Define default command.  
CMD ["redis-server", "/etc/redis/redis.conf"]  
  
# Expose ports.  
EXPOSE 6379  

