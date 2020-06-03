FROM ubuntu:17.04  
MAINTAINER Jan Kunzmann <jan-docker@phobia.de>  
  
RUN apt-get update && apt-get install -y \  
systemd \  
mailgraph jq \  
nginx fcgiwrap \  
&& apt-get clean \  
&& rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \  
&& rm /etc/nginx/sites-enabled/default  
  
COPY script/mailgraph-stream-journal.sh /app/mailgraph-stream-journal.sh  
COPY config/nginx.conf /etc/nginx/  
  
VOLUME /var/lib/mailgraph  
  
EXPOSE 80  
  
ENTRYPOINT ["/app/mailgraph-stream-journal.sh"]  

