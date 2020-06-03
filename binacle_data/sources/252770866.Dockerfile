FROM aggr/consul-agent:0.6  
MAINTAINER Mikhail Baykov <mike@baikov.com>  
  
ENV CONSUL_SERVER 1  
ENV CONSUL_DNS_ALLOW_STALE 0  
ENV CONSUL_DNS_MAX_STALE ""  
ENV CONSUL_UI 1  
ENV CONSUL_UI_DIR /ui  
  
ENTRYPOINT ["/bin/consul_launcher"]  

