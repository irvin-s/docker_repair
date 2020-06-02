FROM eeacms/bise.catalogue:latest  
  
COPY config/database.yml /app/config/database.yml  
COPY config/elasticsearch.yml /app/config/elasticsearch.yml  
COPY config/ldap.yml /app/config/ldap.yml  
COPY config/redis.yml /app/config/redis.yml  
COPY config/ssmtp.conf /etc/ssmtp/ssmtp.conf  

