FROM logstash:2.3.2-1  
MAINTAINER Dennis Stritzke <dennis@stritzke.me>  
  
RUN logstash-plugin install --development

