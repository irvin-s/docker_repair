# Docker container for DivvyCloud applications  
FROM divvycloud/base  
MAINTAINER DivvyCloud  
  
# Install DivvyCloud  
RUN easy_install -i http://release.divvycloud.com mysql-connector-python  
RUN easy_install -i http://packages.divvycloud.com/simple/ divvycloud  
  
# Copy files over  
COPY scripts/* /  
COPY plugins/ /plugins/  
COPY config/* config/  
COPY available-plugins/ available-plugins/  
RUN chmod +x uwsgi.py uwsgi.sh entrypoint.sh setup_mysql.sh  

