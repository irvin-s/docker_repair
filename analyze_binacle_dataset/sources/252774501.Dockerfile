FROM alpine:latest  
LABEL maintainer "AMSSN <info@amssn.eu>"  
ENV TZ='Europe/Berlin'  
ADD data /tmp/  
RUN chmod +x /tmp/*.sh ; /tmp/setup.sh  
  
# port provision  
EXPOSE 53/udp 53/tcp 8953/tcp  
  
# av daemon bootstrapping  
CMD ["/entry.sh"]  

