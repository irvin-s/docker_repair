FROM fluent/fluentd  
MAINTAINER andrew.j.matheny@gmail.com  
  
USER root  
  
ENV PATH /home/fluent/.gem/ruby/2.3.0/bin:$PATH  
ENV GEM_PATH /home/fluent/.gem/ruby/2.3.0  
RUN gem install fluent-plugin-redis-store:0.1.1  
RUN gem install excon:0.46.0  
RUN gem install docker-api:1.29.0  
RUN gem install lru_redux:1.1.0  
RUN gem install fluent-plugin-rename-key:0.2.0  
RUN gem install fluent-plugin-grep:0.3.4  
RUN gem install fluent-plugin-record-modifier:0.4.1  
  
ADD plugins/* /fluentd/plugins/  
ADD fluent.conf /fluentd/etc/fluent.conf  
ADD run.sh /  
  
ENTRYPOINT ["/run.sh"]  

