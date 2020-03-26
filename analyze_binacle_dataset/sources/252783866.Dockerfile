FROM ubuntu  
  
RUN apt-get update && apt-get install -y apache2-utils curl  
  
ADD ./test.sh /bin/test  
RUN chmod +x /bin/test  
ADD ./webserver /bin/webserver  
RUN chmod +x /bin/webserver  
  
ENTRYPOINT ["/bin/test"]

