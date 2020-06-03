FROM domecloud/alpine:glibc  
MAINTAINER Dome C. <dome@tel.co.th>  
  
COPY start.sh /start.sh  
RUN chmod +x /start.sh  
COPY bin/prometheus /bin/prometheus  
COPY bin/promtool /bin/promtool  
COPY bin/prometheus.yml /etc/prometheus/prometheus.yml  
COPY bin/console_libraries/ /etc/prometheus/  
COPY bin/consoles/ /etc/prometheus/  
  
WORKDIR /prometheus  
  
ENV TERM screen-256color  
ENV SHELL=/bin/bash  
EXPOSE 9090  
ENTRYPOINT ["/start.sh"]  

