FROM tutum/apache-php  
ADD revive-adserver-3.2.2.zip /tmp/  
WORKDIR /tmp/  
RUN apt-get -y update && apt-get -y install unzip  
RUN unzip revive-adserver-3.2.2  
RUN rm -rf /app && mkdir /app && mv revive-adserver-3.2.2/* /app/  
RUN chmod -R a+w /app/var  
RUN chmod -R a+w /app/var/cache  
RUN chmod -R a+w /app/var/plugins  
RUN chmod -R a+w /app/var/templates_compiled  
RUN chmod -R a+w /app/plugins  
RUN chmod -R a+w /app/www/admin/plugins  
RUN chmod 777 /app/www/images  
EXPOSE 80 443  
CMD ["/run.sh"]  

