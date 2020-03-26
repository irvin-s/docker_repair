FROM centos:6  
MAINTAINER joe <joe@valuphone.com>  
  
LABEL os="linux" \  
os.distro="centos" \  
os.version="6"  
  
LABEL image.name="kazoo-ui" \  
image.version="3.22"  
  
ENV KAZOO_UI_VERSION=3.22  
ENV TERM=xterm  
  
COPY setup.sh /tmp/setup.sh  
RUN /tmp/setup.sh  
  
COPY entrypoint /usr/bin/entrypoint  
  
ENV HOME=/var/www \  
PATH=/var/www/bin:$PATH  
  
ENV HTTPD_LOG_LEVEL=error  
  
EXPOSE 80  
VOLUME ["/var/www/html"]  
  
# USER apache  
WORKDIR /var/www  
  
CMD ["/usr/bin/entrypoint"]  

