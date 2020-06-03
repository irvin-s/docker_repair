FROM redis  
RUN apt-get update  
RUN apt-get install -yy -q python  
  
COPY redis-master.conf /redis-master/redis.conf  
COPY redis-slave.conf /redis-slave/redis.conf  
COPY run.sh /run.sh  
  
RUN mkdir -p /redis-sentinel  
VOLUME /redis-sentinel  
  
CMD [ "/run.sh" ]  
ENTRYPOINT [ "sh", "-c" ]  

