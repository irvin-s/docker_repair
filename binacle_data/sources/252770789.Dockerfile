FROM elasticsearch:2.3  
MAINTAINER agate<agate.hao@gmail.com>  
  
RUN /usr/share/elasticsearch/bin/plugin install elasticsearch/license/latest  
RUN /usr/share/elasticsearch/bin/plugin install elasticsearch/watcher/latest  
  
ADD docker-entrypoint.sh /  

