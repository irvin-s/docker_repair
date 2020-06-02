FROM ubuntu:latest  
COPY ./entrypoint.sh /  
ENTRYPOINT ["/entrypoint.sh"]  

