FROM centurylink/apache-php:latest  
MAINTAINER CenturyLink  
  
# Install packages  
RUN apt-get update && \  
DEBIAN_FRONTEND=noninteractive apt-get -y upgrade && \  
DEBIAN_FRONTEND=noninteractive apt-get -y install supervisor pwgen && \  
apt-get -y install mysql-client  
  
# Download Wordpress into /app  
RUN rm -fr /app && mkdir /app && \  
curl -L -O http://wordpress.org/wordpress-4.0.tar.gz && \  
tar -xzvf wordpress-4.0.tar.gz -C /app --strip-components=1 && \  
rm wordpress-4.0.tar.gz  
  
# Add wp-config with info for Wordpress to connect to DB  
ADD wp-config.php /app/wp-config.php  
RUN chmod 644 /app/wp-config.php  
  
# Fix permissions for apache  
RUN chown -R www-data:www-data /app  
  
# Add script to create 'wordpress' DB  
ADD run.sh run.sh  
RUN chmod 755 /*.sh  
  
EXPOSE 80  
CMD ["/run.sh"]  

