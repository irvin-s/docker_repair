FROM alpine:latest  
  
# -- add cifs tools  
RUN apk add --update --no-cache cifs-utils  
  
# -- add entrypoint script  
COPY ./docker-entrypoint.sh /  
RUN chmod +x /docker-entrypoint.sh  
  
# -- expose /mnt/cifs directory as volume before mount bellow  
VOLUME /mnt/cifs  
  
# -- set entrypoint script  
ENTRYPOINT ["/docker-entrypoint.sh"]  

