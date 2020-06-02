FROM centos:7  
MAINTAINER Donald Simpson <donaldsimpson@gmail.com>  
  
RUN mkdir /opt/prometheus && \  
mkdir /data && \  
chmod ugo+rw /data/  
  
VOLUME /opt/prometheus/  
  
COPY prometheus-* /opt/prometheus/  
  
RUN chmod +x /opt/prometheus/prometheus &&\  
chmod +x /opt/prometheus/promtool  
  
EXPOSE 9090  
USER nobody  
  
ENTRYPOINT ["/opt/prometheus/prometheus"]  
CMD [ "-config.file", "/opt/prometheus/prometheus.yml"]  
  

