FROM djmattyg007/arch-runit-base:2017.10.27-1  
MAINTAINER djmattyg007  
  
ENV JSONEDITORIMAGE_VERSION=2017.10.27-1  
# Add install bash script  
COPY setup/root/*.sh /root/  
# Add runit init script  
COPY setup/init.sh /etc/service/nginx/run  
# Add nginx server block files and templates  
COPY setup/*.ngx /etc/jsoneditor/nginx/  
# Add main nginx config file  
COPY setup/nginx.custom.conf /etc/nginx/  
COPY setup/index.html /data/index.html  
  
ENV JSONEDITOR_VERSION=5.9.6  
# Run bash script to install nginx and download the jsoneditor code  
RUN /root/install.sh && \  
rm /root/*.sh  
  
ENTRYPOINT ["/usr/bin/init"]  

