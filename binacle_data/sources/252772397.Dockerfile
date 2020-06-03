FROM aviata/imply-base  
  
COPY load-samples /usr/bin/load-samples  
  
RUN chmod 700 /usr/bin/load-samples  
  
EXPOSE 8080 8081 8082 8083 8084 8090 9095  
# 8080 - Druid Port  
# 8081 - Druid Coordinator  
# 8082 - Druid Broker  
# 8083 - Druid Historical  
# 8084 - Druid Overlord  
# 8090 - Druid Indexing Service  
# 9095 - Bard Service  
CMD ./bin/supervise -c conf/supervise/quickstart.conf  

