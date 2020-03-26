FROM java:8  
RUN apt-get update && apt-get install -y curl git maven unzip  
  
COPY ./entrypoint.sh /  
  
ENV DB_HOST cms-db  
ENV DB_USER root  
ENV DB_DATABASE cms  
ENV DB_PORT 3306  
RUN chmod +x /entrypoint.sh  
  
EXPOSE 8080  
CMD ["./entrypoint.sh"]  

