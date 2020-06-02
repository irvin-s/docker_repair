FROM mesosphere/marathon-lb:v1.5.0  
RUN mkdir -p /etc/ssl/astronomer  
WORKDIR /etc/ssl/astronomer  
ADD ssl/STAR_astronomer_io_v2.pem .  

