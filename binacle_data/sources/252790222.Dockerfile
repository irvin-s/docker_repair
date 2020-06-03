FROM cannin/r-base:ubuntu-16.04_r-3.4.1_java-8  
# No interactive prompts  
ENV DEBIAN_FRONTEND noninteractive  
  
## Define versions required:  
ENV VERSION_OPENCPU 2.0  
# INSTALL ADDITIONAL TOOLS  
RUN apt-get update  
RUN apt-get install -y htop wget curl software-properties-common  
  
# INSTALL  
RUN \  
add-apt-repository -y ppa:opencpu/opencpu-${VERSION_OPENCPU} && \  
apt-get update && \  
apt-get install -y opencpu-server && \  
apt-get clean autoclean && \  
apt-get autoremove -y && \  
rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*  
  
# Prints apache logs to stdout  
RUN \  
ln -sf /proc/self/fd/1 /var/log/apache2/access.log && \  
ln -sf /proc/self/fd/1 /var/log/apache2/error.log && \  
ln -sf /proc/self/fd/1 /var/log/opencpu/apache_access.log && \  
ln -sf /proc/self/fd/1 /var/log/opencpu/apache_error.log  
  
# Set opencpu password so that we can login  
RUN \  
echo "opencpu:opencpu" | chpasswd  
  
# PORTS  
EXPOSE 80  
EXPOSE 443  
EXPOSE 8004  
# Start non-daemonized webserver  
CMD apachectl -DFOREGROUND  

