FROM nginx:1.9.6  
MAINTAINER Mark Turner <mark.turner@collinsongroup.com>  
  
COPY src /configScripts  
COPY config /etc/nginxTemplates  
  
RUN chmod +x /configScripts/start.sh \  
&& mkdir -p /etc/logstash/conf.d/ \  
&& cd /configScripts \  
&& apt-get update \  
&& apt-get install -y python-pip \  
&& pip install -r requirements.txt \  
&& apt-get remove -y python-pip \  
&& apt-get clean  
  
ENV PASSTHRU_PASSWORD=guest  
ENV PASSTHRU_USERNAME=guest  
ENV PASSTHRU_DESTINATION=http://localhost:8080  
  
ENTRYPOINT ["/configScripts/start.sh"]  
CMD ["nginx", "-g", "daemon off;"]  

