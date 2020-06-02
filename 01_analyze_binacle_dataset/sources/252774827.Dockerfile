FROM python:3-alpine  
  
LABEL maintainer=battlecl0ud  
LABEL email=battlecloud@khast3x.club  
LABEL image=trevorc2_server  
LABEL source=https://github.com/trustedsec/trevorc2.git  
  
RUN apk update  
RUN apk add --no-cache git openssl ca-certificates build-base python3-dev wget  
  
RUN git clone https://github.com/trustedsec/trevorc2.git trevorc2_server  
WORKDIR trevorc2_server  
RUN pip install requests  
RUN pip install -r requirements.txt  
  
# Expose ports  
EXPOSE 80 443  
# Start tool  
VOLUME ["/loot"]  
COPY docker-entrypoint.sh .  
ENTRYPOINT ["./docker-entrypoint.sh"]  

