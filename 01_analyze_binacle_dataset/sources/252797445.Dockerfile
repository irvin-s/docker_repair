FROM m3adow/ubuntu_dumb-init_gosu:latest  
MAINTAINER Carl Mercier <foss@carlmercier.com>  
  
COPY ["install.sh", "/tmp/"]  
COPY ["download.sh", "/usr/local/bin/"]  
COPY ["seafile_download_url", "/usr/local/bin/"]  
COPY ["seafile-entrypoint.sh", "/usr/local/bin/"]  
  
RUN /tmp/install.sh  
  
EXPOSE 8000 8082  
VOLUME /seafile  
  
ENV SEAFILE_NAME=Seafile  
ENV SEAFILE_ADDRESS=127.0.0.1  
ENV SEAFILE_ADMIN=admin@example.org  
ENV SEAFILE_ADMIN_PW=  
ENV PRO=false  
ENV FORCE_PERMISSIONS=false  
  
ENTRYPOINT ["/usr/bin/dumb-init", "/usr/local/bin/seafile-entrypoint.sh"]  

