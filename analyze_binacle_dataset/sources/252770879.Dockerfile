FROM elasticsearch:5.5  
MAINTAINER Ali Ghassabian <aghasabian@hotmail.com>  
  
RUN bin/elasticsearch-plugin install x-pack  
ENTRYPOINT ["/docker-entrypoint.sh"]  
CMD ["elasticsearch"]  

