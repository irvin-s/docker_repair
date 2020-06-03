FROM kibana:5.5  
MAINTAINER Ali Ghassabian <ghasabian@hotmail.com>  
  
RUN /usr/share/kibana/bin/kibana-plugin install x-pack  
ENTRYPOINT ["/docker-entrypoint.sh"]  
CMD ["kibana"]  

