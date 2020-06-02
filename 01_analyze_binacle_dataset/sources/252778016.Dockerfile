FROM rethinkdb:latest  
MAINTAINER Antoine POPINEAU <antoine.popineau@appscho.com>  
  
RUN apt update && apt install -y bind9-host  
  
COPY docker-entrypoint.sh /  
  
ENTRYPOINT [ "/docker-entrypoint.sh" ]  
CMD [ "rethinkdb", "--bind", "all" ]  

