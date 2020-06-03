FROM python:2-alpine  
  
LABEL maintainer=battlecl0ud  
LABEL email=battlecloud@khast3x.club  
LABEL image=sqlmap  
LABEL source=https://github.com/sqlmapproject/sqlmap.git  
  
RUN apk add --no-cache git  
  
RUN git clone https://github.com/sqlmapproject/sqlmap.git sqlmap  
WORKDIR sqlmap  
  
# Expose ports  
# Start tool  
VOLUME ["/loot"]  
COPY docker-entrypoint.sh .  
ENTRYPOINT ["./docker-entrypoint.sh"]  

