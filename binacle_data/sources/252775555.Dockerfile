FROM ubuntu:latest  
  
ENV ORAY_HOME /usr/local/oray  
RUN mkdir -p ${ORAY_HOME}  
  
RUN mkdir -p /tmp/  
add phddns.deb /tmp/hddns.deb  
RUN dpkg -i /tmp/hddns.deb && rm /tmp/hddns.deb  
  
RUN apt-get update && apt-get install -y supervisor  
ADD supervisord.conf /supervisord.conf  
COPY /supervisord.conf /etc/supervisor/conf.d/supervisord.conf  
  
EXPOSE 6060  
CMD ["/usr/bin/supervisord"]  

