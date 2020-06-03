FROM vigour/redis-base:latest
ENV DEBIAN_FRONTEND noninteractive
##///*******************************************************/
## set redis default to bind to all nic's.
RUN sed -i 's/^\(bind .*\)$/# \1/' /etc/redis/redis.conf
#change ports as needed from 6379 to ...
#RUN sed -i "s/port 6379/port 6380/" /etc/redis/redis.conf
##//------------------------
## add a custom start script 
##//------------------------
RUN touch /start_slave.sh && chmod +x /start_slave.sh && \
echo "#!/bin/bash" > /start_slave.sh > /start_slave.sh && \
echo "#" >> /start_slave.sh && \
echo "if [ -z \"$REDIS_MASTER_PORT_6379_TCP_ADDR\" ]; then" >> /start_slave.sh && \
echo "echo \"REDIS_MASTER_PORT_6379_TCP_ADDR not defined. Did you run with -link?\";" >> /start_slave.sh && \ 
echo "exit 7;" >> /start_slave.sh && \
echo "fi" >> /start_slave.sh && \ 
echo "# exec allows redis-server to receive signals for clean shutdown" >> /start_slave.sh && \
echo "exec /usr/local/bin/redis-server --slaveof $REDIS_MASTER_PORT_6379_TCP_ADDR $REDIS_MASTER_PORT_6379_TCP_PORT $*" >> /start_slave.sh
##///*******************************************************/
EXPOSE 6379
VOLUME ["/data"]
ENTRYPOINT ["./start-slave.sh", "--dir", "/data"]

##//////////////////////////////////////////////////////////////////
# build: docker build -t vigour/redis-slave .
# run: docker run -P --detach --name=redis0_slave --link=redis0:redis_master vigour/redis-slave 
# cli: docker run -P -it --rm --name=redis0 vigour/redis-master
