FROM debian  
MAINTAINER esteban.sastre@tenforce.com  
  
ENV PCAP_WRITE_DIR 'pcap/'  
ENV CONTAINER_DATA_DIR 'containers/'  
ENV CONTAINER_DATA_FILE 'containers.json'  
ENV SLEEP_PERIOD '5'  
RUN apt-get update && apt-get -y -q install \  
tcpdump supervisor jq net-tools && \  
apt-get clean  
  
RUN mv /usr/sbin/tcpdump /usr/bin/tcpdump  
  
COPY ./supervisord.conf /etc/supervisord.conf  
COPY . /app/  
WORKDIR /app  
  
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisord.conf"]  

