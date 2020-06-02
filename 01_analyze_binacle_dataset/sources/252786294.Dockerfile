FROM prom/alertmanager  
MAINTAINER "The Doalitic Team" <devops@doalitic.com>  
  
# The following environment variables are available:  
#  
# AM_WEBHOOK_URL default = https://monitor:443/v1/alerts  
# AM_GROUP_WAIT default = 1m  
# AM_GROUP_INTERVAL default = 5m  
# AM_REPEAT_INTERVAL default = 6h  
# The following configs are inherited:  
#  
# EXPOSE 9093  
# VOLUME [ "/alertmanager" ]  
#  
RUN mkdir -p /usr/local/bin  
ADD dockerize /usr/local/bin/  
  
RUN mkdir /templates  
ADD config.yml.tpl /templates/  
  
ENTRYPOINT [ "/usr/local/bin/dockerize", \  
"-template", "/templates/config.yml.tpl:/etc/alertmanager/config.yml" ]  
CMD [ "/bin/alertmanager", \  
"-config.file=/etc/alertmanager/config.yml", \  
"-storage.path=/alertmanager" ]  

