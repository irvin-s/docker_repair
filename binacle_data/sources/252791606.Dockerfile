FROM fluent/fluentd:latest-onbuild  
MAINTAINER Keaton Choi <keaton@dailyhotel.com>  
  
# USER fluent  
USER root  
WORKDIR /home/fluent  
ENV PATH /home/fluent/.gem/ruby/2.3.0/bin:$PATH  
  
RUN gem install fluent-plugin-secure-forward && \  
gem install fluent-plugin-elasticsearch --no-rdoc --no-ri && \  
gem install fluent-plugin-parser && \  
gem install fluent-plugin-concat  
  
EXPOSE 24284  
CMD fluentd -c /fluentd/etc/$FLUENTD_CONF -p /fluentd/plugins $FLUENTD_OPT  

