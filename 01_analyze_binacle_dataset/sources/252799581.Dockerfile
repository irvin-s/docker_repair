FROM phusion/passenger-ruby21  
MAINTAINER Jeff Dickey jeff@dickeyxxx.com  
  
RUN gem install newrelic_haproxy_agent  
RUN newrelic_haproxy_agent install  
ADD newrelic_haproxy_agent.yml /etc/newrelic/newrelic_haproxy_agent.yml  
  
RUN useradd -m agent  
  
CMD ["/sbin/my_init"]  
  
RUN mkdir /etc/service/newrelic_haproxy_agent  
ADD newrelic_haproxy_agent.sh /etc/service/newrelic_haproxy_agent/run  

