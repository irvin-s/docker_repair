# VERSION 1.0  
# DOCKER-VERSION 1.2.0  
# AUTHOR: Richard Lee <lifuzu@gmail.com>  
# DESCRIPTION: RethinkDB Image Container  
FROM dockerbase/service  
  
# Run dockerbase script  
ADD rethinkdb.sh /dockerbase/  
RUN /dockerbase/rethinkdb.sh  
  
RUN mkdir -p /etc/service/rethinkdb  
ADD build/runit/rethinkdb /etc/service/rethinkdb/run  
#VOLUME ["/data/db"]  
EXPOSE 8080 28017 29017  

