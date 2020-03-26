FROM beginor/mono:5.10.1.47  
LABEL MAINTAINER="beginor <beginor@qq.com>"  
  
# COPY startup script and make it executable  
COPY src/bootstrap.sh /usr/bin/  
  
# Install wget download and install jexus, then cleanup  
COPY src/install.sh /tmp/  
RUN /tmp/install.sh  
  
# Expost ports  
EXPOSE 80 443  
# Define volumes  
VOLUME ["/usr/jexus/siteconf", "/var/www", "/usr/jexus/log"]  
# Define workdir  
WORKDIR /usr/jexus  
# Define startup scripts;  
ENTRYPOINT ["/usr/bin/bootstrap.sh"]  
# Healthy check  
HEALTHCHECK \--interval=30s --timeout=30s --start-period=30s --retries=3 \  
CMD curl -f http://127.0.0.1 || exit 1  

