FROM ubuntu  
RUN apt update && \  
apt install -y apache2 libapache2-mod-jk  
COPY ./entrypoint.sh /entrypoint.sh  
EXPOSE 80  
ENTRYPOINT ["/entrypoint.sh"]  

