FROM kibana:4.6.2  
MAINTAINER Loïc Ambrosini <loic.ambrosini@me.com>  
  
RUN kibana plugin --install elastic/sense  
  
EXPOSE 5601  
ENTRYPOINT ["/docker-entrypoint.sh"]  
CMD ["kibana"]

