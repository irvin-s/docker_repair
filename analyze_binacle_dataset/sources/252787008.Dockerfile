FROM ubuntu:16.04  
RUN apt-get update && apt-get install sphinxsearch -y  
  
RUN apt-get autoremove -y && apt-get autoclean  
  
RUN cp /etc/sphinxsearch/sphinx-min.conf.dist /etc/sphinxsearch/sphinx.conf  
  
RUN mkdir /data  
  
VOLUME ["/etc/sphinxsearch"]  
  
VOLUME ["/data"]  
  
EXPOSE 9312 9306  
CMD /usr/bin/searchd -c /etc/sphinxsearch/sphinx.conf --nodetach

