FROM postgres:9.6.5-alpine  
  
MAINTAINER Alexey Zhokhov <alexey@zhokhov.com>  
  
VOLUME ["/var/lib/postgresql/data", "/var/log/postgresql"]  
  
COPY docker-entrypoint.sh /  
RUN chmod a+x /docker-entrypoint.sh  
  
COPY postgresql-tuning.sh /  
RUN chmod a+x /postgresql-tuning.sh  
  
ENTRYPOINT ["/docker-entrypoint.sh"]  
  
EXPOSE 5432  
CMD ["postgres"]  

