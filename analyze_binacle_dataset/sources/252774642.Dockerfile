FROM analyser/fluentd  
MAINTAINER barwell  
  
RUN gem install fluent-plugin-forest --no-rdoc --no-ri  
  
EXPOSE 24224  
CMD fluentd -c /fluentd/etc/$FLUENTD_CONF -p /fluentd/plugins $FLUENTD_OPT  

