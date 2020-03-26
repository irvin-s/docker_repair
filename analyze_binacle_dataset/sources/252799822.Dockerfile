FROM digitalcz/ubuntu  
  
RUN apt-get update && apt-get -y install supervisor  
  
RUN mkdir -p /var/log /var/run  
  
COPY supervisord.conf /etc/supervisor/supervisord.conf  
  
EXPOSE 9001  
CMD ["/usr/bin/supervisord", "-n"]

