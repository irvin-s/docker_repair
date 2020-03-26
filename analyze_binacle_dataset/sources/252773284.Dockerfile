FROM debian:jessie  
MAINTAINER Peter van Heusden <pvh@sanbi.ac.za>  
  
ADD config-files /config-files  
  
VOLUME ["/conf", "/var/log", "/var/backup", "/root/.secret", \  
"/opt/java", "/opt/tomcat", \  
"/var/lib/pgsql/9.3/data", \  
"/home/irods", "/etc/irods"]  
  
ADD init-config.sh /usr/local/bin/init-config.sh  
# Keep container from shutting down until explicitly stopped  
ENTRYPOINT ["/bin/sh"]  
CMD ["/usr/local/bin/init-config.sh"]  

