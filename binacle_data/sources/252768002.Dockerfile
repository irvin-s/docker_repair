FROM adamant/amp  
  
USER root  
  
COPY steamcmd-test /usr/bin  
  
RUN chmod +rx /usr/bin/steamcmd-test  
  
USER amp  
  
ENV MODULE=StarBound  
  
EXPOSE 8080 21025 21026  

