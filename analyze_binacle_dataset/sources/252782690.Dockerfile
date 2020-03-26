FROM nsqio/nsqd  
  
ADD ./docker-entrypoint.sh /  
RUN chmod +x ./docker-entrypoint.sh  
ENTRYPOINT ["./docker-entrypoint.sh", "--data-path=/data"]  

