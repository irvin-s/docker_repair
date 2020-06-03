# https://hub.docker.com/r/frolvlad/alpine-glibc/  
FROM frolvlad/alpine-glibc  
  
RUN apk add --no-cache redis sed bash  
  
COPY redis.conf /usr/local/etc/redis/redis.conf  
COPY run.sh /run.sh  
RUN chmod u+x /run.sh  
CMD [ "/run.sh" ]  
  
ENTRYPOINT [ "bash", "-c" ]

