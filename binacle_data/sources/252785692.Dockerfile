From nginx  
ADD consul-template /bin/consul-template  
ADD nginx.conf /tmp/nginx.ctmpl  
ADD start.sh start.sh  
EXPOSE 80  
ENV "SERVICE_NAME=agent"  
ENTRYPOINT ["/bin/bash", "start.sh"]  
  

