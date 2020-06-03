FROM ubuntu:15.04  
RUN apt-get update -q && \  
apt-get dist-upgrade -y && \  
apt-get install -y pdns-backend-remote software-properties-common && \  
apt-add-repository -y ppa:danieldent/pidunu && \  
apt-get update -q && \  
apt-get install -y pidunu && \  
rm -Rf /var/lib/apt /var/cache/apt  
  
EXPOSE 53  
EXPOSE 53/UDP  
CMD ["/sbin/pidunu", "/usr/sbin/pdns_server", "--daemon=no"]  

