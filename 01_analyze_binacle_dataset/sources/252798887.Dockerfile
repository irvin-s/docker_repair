# Update version number depending on mariadb stable release  
FROM mariadb:10.1.12  
MAINTAINER Onni Hakala - Geniem Oy <onni.hakala@geniem.com>  
  
ADD root-files /  
  
ENTRYPOINT ["/docker-entrypoint.sh"]  
  
# Expose mysql port and replication ports  
EXPOSE 3306 4444 4567 4568  
ENV TERM="xterm"  
CMD ["mysqld"]  

