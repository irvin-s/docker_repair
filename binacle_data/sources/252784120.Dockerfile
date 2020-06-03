# Pin to version of notebook image that includes start-singleuser.sh script  
FROM biosustain/cobra-notebook:latest  
RUN apt-get -y install cifs-utils  
# Install packages in default Python 3 environment  
RUN pip install \  
beautifulsoup4==4.4.*  
  
# Install packages in Python 2 environment  
RUN $CONDA_DIR/envs/python2/bin/pip install \  
beautifulsoup4==4.4.*  
# Use custom startup script  
USER root  
COPY docker-entrypoint.sh /srv/docker-entrypoint.sh  
COPY mount_directory.sh /srv/mount_directory.sh  
ENTRYPOINT ["tini", "--", "/srv/docker-entrypoint.sh"]  
CMD ["start-singleuser.sh"]  

