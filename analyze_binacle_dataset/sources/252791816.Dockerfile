FROM damonmorgan/openelec-dependencies:latest  
MAINTAINER damon.morgan@gmail.com  
  
RUN git clone https://github.com/OpenELEC/OpenELEC.tv.git  
  
VOLUME /builds  
  
COPY entrypoint.sh /opt/entrypoint.sh  
RUN chmod +x /opt/entrypoint.sh  
  
WORKDIR /  
  
ENTRYPOINT ["/opt/entrypoint.sh"]  

