FROM danielguerra/alpine-kibana  
MAINTAINER Daniel Guerra <daniel.guerra69@gmail.com>  
  
RUN /usr/share/kibana/bin/kibana-plugin install x-pack  
  
EXPOSE 5601  
ENTRYPOINT ["docker-entrypoint.sh"]  
CMD ["kibana"]  

