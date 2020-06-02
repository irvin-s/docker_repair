FROM ruby:alpine  
  
RUN gem install newrelic_resque_agent  
  
COPY newrelic_resque_agent.yml.tpl /etc/newrelic/newrelic_resque_agent.yml.tpl  
ADD ./run.sh .  
  
CMD ["./run.sh"]

