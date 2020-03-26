FROM stajkowski/redis-base:latest
ENV DEBIAN_FRONTEND noninteractive
##///*******************************************************/
## set redis default to bind to all nic's.
RUN sed -i 's/^\(bind .*\)$/# \1/' /etc/redis/redis.conf
#change ports as needed from 6379 to ...
RUN echo "port 6380" > /etc/redis/sentinel.conf
RUN echo "sentinel monitor mymaster docker-redis 6379 2" >> /etc/redis/sentinel.conf
RUN echo "sentinel down-after-milliseconds mymaster 60000" >> /etc/redis/sentinel.conf
RUN echo "sentinel failover-timeout mymaster 180000" >> /etc/redis/sentinel.conf
RUN echo "sentinel parallel-syncs mymaster 1" >> /etc/redis/sentinel.conf

##///*******************************************************/
EXPOSE 6380
VOLUME ["/data"]
WORKDIR /data
ENTRYPOINT ["redis-server", "/etc/redis/sentinel.conf", "--sentinel"]

##//////////////////////////////////////////////////////////////////
# build: docker build -t vigour/redis-master .
# run: docker run -v ~/data/redis0:/data -it --detach --name=redis0 vigour/redis-master
# cli: docker run -v ~/data/redis0:/data -it --rm --name=redis0 vigour/redis-master
