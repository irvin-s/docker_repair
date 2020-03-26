#  
# DynomiteDB: Redis server runtime container  
#  
FROM dynomitedb/base  
  
MAINTAINER Akbar S. Ahmed <akbar@dynomitedb.com>  
  
#  
# Environment variables  
#  
ENV REDIS_USER dynomite  
ENV REDIS_GROUP dynomite  
  
#  
# Install dependencies  
#  
RUN groupadd -r $REDIS_GROUP && \  
useradd -r -g $REDIS_GROUP $REDIS_USER && \  
apt-get update && \  
apt-get install -y \  
software-properties-common \  
apt-transport-https \  
ca-certificates && \  
apt-key adv --keyserver keyserver.ubuntu.com --recv-keys FB3291D9 && \  
add-apt-repository "deb https://apt.dynomitedb.com/ trusty main" && \  
apt-get update && \  
apt-get install -y dynomitedb-redis && \  
rm -rf /var/lib/apt/lists/*  
  
#  
# Mountable directories  
#  
#VOLUME ["/dir-on-host:/dir-in-container"]  
#  
# Working directory (similar to `cd $WORKDIR` for all following commands)  
#  
WORKDIR /  
  
#  
# Default command  
#  
COPY docker-entrypoint.sh /entrypoint.sh  
COPY redis.conf /etc/dynomitedb/redis.conf  
RUN chmod +x /entrypoint.sh  
ENTRYPOINT ["/entrypoint.sh"]  
CMD dynomitedb-redis-server /etc/dynomitedb/redis.conf  
  
#  
# Expose ports  
#  
EXPOSE 22122  

