FROM dimitri/pgloader  
  
WORKDIR /data-loader  
  
RUN apt-get update && \  
apt-get install -y awscli zip  
  
COPY ppl_people_load /data-loader/  
  
COPY ent_entity_load /data-loader/  
  
COPY rds-load /rds-load  
  
RUN chmod +x /rds-load  
  
CMD ["/rds-load"]  

