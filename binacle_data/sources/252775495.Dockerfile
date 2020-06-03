FROM ruby:2.1  
MAINTAINER New Relic <support@newrelic.com>  
  
RUN mkdir -p /data/app  
ADD write-configs required-variables.txt /data/app/  
WORKDIR /data/app/  
  
RUN gem install newrelic_f5_plugin  
  
ENV NEW_RELIC_LICENSE_KEY="" NEW_RELIC_LOG_LEVEL="debug"  
ENV PLUGIN_HOSTNAME="" PLUGIN_PORT="161" PLUGIN_SNMP_COMMUNITY="public"  
CMD ./write-configs && f5_monitor run  

