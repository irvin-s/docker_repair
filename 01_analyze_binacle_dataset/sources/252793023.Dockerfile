FROM docker.elastic.co/kibana/kibana:5.1.2  
EXPOSE 8080  
RUN bin/kibana-plugin remove x-pack  

