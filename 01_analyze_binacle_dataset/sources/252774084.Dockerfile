FROM store/oracle/serverjre:8  
RUN mkdir /tmp/tolgadb  
RUN mkdir /tmp/dropzone  
RUN mkdir /application  
RUN mkdir /application/log  
  
COPY start-cairns.sh /  
  
EXPOSE 7080  
VOLUME [ "/application" ]  
  
ENTRYPOINT ./start-cairns.sh  

