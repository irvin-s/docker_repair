FROM docker.elastic.co/beats/filebeat:5.2.2  
USER root  
RUN apt-get install -y jq  
COPY filebeat.yml filebeat.yml  
COPY entrypoint.sh /usr/bin/entrypoint.sh  
USER filebeat  
CMD entrypoint.sh  

