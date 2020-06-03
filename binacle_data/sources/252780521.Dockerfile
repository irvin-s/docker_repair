FROM elasticsearch:1.7  
MAINTAINER Michael Garrez <michael.garrez@gmail.com>  
  
ENV REFRESHED_AT 2016-02-12  
RUN cd /usr/share/elasticsearch/bin/ && plugin install mobz/elasticsearch-head  

