FROM dostolu/alpine-redis-node6  
  
RUN \  
apk add --no-cache mongodb && \  
rm /usr/bin/mongoperf  
  
VOLUME /data/db  
EXPOSE 27017 28017  
EXPOSE 6379  
COPY run.sh /root  
ENTRYPOINT ["/bin/sh", "/root/run.sh" ]  
CMD [ "mongod" ]  
CMD ["redis-server"]

