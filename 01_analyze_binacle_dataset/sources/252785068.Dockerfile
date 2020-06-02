FROM ruby:2.2-slim  
MAINTAINER coding4m coding4m@gmail.com  
  
USER root  
  
LABEL services sys  
ENV LOGS_IGNORE true  
  
RUN apt-get update && apt-get install gcc make -y  
RUN gem sources --add https://ruby.taobao.org/ --remove https://rubygems.org/  
RUN gem install fluentd --no-ri --no-rdoc  
RUN gem install fluent-plugin-docker-metrics  
RUN gem install fluent-plugin-elasticsearch  
RUN gem install fluent-plugin-record-reformer  
RUN apt-get remove gcc make -y && apt-get clean && rm -rf /var/lib/apt/lists/*  
  
ADD fluent.conf /etc/fluent/  
ADD start.sh /app/  
CMD ["/bin/bash", "/app/start.sh"]

