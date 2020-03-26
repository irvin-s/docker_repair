FROM mdillon/postgis:9.6  
ENV PGDATA /data  
VOLUME /data  
  
RUN chown -R postgres /data  
  
RUN apt-get install openssl  
  
RUN mkdir -p /docker-entrypoint-initdb.d  
COPY ./init-ssl.sh /docker-entrypoint-initdb.d/init-ssl.sh  
  
EXPOSE 5432  
ENTRYPOINT ["/docker-entrypoint.sh"]  
  
CMD ["postgres"]  

