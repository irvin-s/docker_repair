FROM stajkowski/redis-base:latest
ENV DEBIAN_FRONTEND noninteractive
##///*******************************************************/
##// BELOW wil not work via 
##// ENTRYPOINT["redis-server", "/etc/redis/redis.conf"]
##// ^^^ will reqiure intermediate bash.sh run to achieve this"
##// set redis default to bind to all nic's.
#//RUN sed -i 's/^\(bind .*\)$/# \1/' /etc/redis/redis.conf
#// #change ports as needed from 6379 to ...
#//RUN sed -i "s/port 6379/port 80/" /etc/redis/redis.conf
#///*******************************************************/

EXPOSE 6379
VOLUME ["/data"]
ENTRYPOINT ["redis-server", "--port", "6379"]

##//////////////////////////////////////////////////////////////////
# build: docker build -t vigour/redis-master .
# run: docker run -p 80:80 -v ~/data/redis0:/data -it --detach --name=redis0 vigour/redis-master
# cli: docker run -v -p 80:80 ~/data/redis0:/data -it --rm --name=redis0 vigour/redis-masters
