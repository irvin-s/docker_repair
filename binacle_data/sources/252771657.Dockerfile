# https://github.com/elastic/kibana-docker  
FROM docker.elastic.co/kibana/kibana:5.2.2  
ADD config/kibana.yml /usr/share/kibana/kibana.yml  

