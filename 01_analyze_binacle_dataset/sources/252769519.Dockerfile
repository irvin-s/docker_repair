FROM debian:stable  
MAINTAINER Anton Ageev <antage@gmail.com>  
  
RUN apt-get update && \  
apt-get install -y pdns-recursor && \  
rm -rf /var/lib/apt/lists/*  
  
EXPOSE 53  
EXPOSE 53/udp  
  
ENTRYPOINT ["/usr/sbin/pdns_recursor"]  
CMD ["--daemon=no", "--local-address=0.0.0.0"]  

