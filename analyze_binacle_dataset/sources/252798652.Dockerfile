FROM derjudge/archlinux-apache-php  
MAINTAINER Marc Richter <mail@marc-richter.info>  
  
# Make PHP settings  
# Load APCu module  
RUN sed -i'' 's#^;\\(extension=apcu.so\\)#\1#g' /etc/php/conf.d/apcu.ini  
# Load iconv module  
RUN sed -i'' 's#^;\\(extension=iconv.so\\)#\1#g' /etc/php/php.ini  
# Load posix module  
RUN sed -i'' 's#^;\\(extension=posix.so\\)#\1#g' /etc/php/php.ini  
# Load bz2 module  
RUN sed -i'' 's#^;\\(extension=bz2.so\\)#\1#g' /etc/php/php.ini  
# Load intl module  
RUN sed -i'' 's#^;\\(extension=intl.so\\)#\1#g' /etc/php/php.ini  
# Load mcrypt module  
RUN sed -i'' 's#^;\\(extension=mcrypt.so\\)#\1#g' /etc/php/php.ini  
# Load exif module  
RUN sed -i'' 's#^;\\(extension=exif.so\\)#\1#g' /etc/php/php.ini  
# Enable mysql extension, disable PDO and mysqli  
RUN sed -i'' 's#^;\\(extension=mysql.so.*$\\)#\1#g' /etc/php/php.ini  
RUN sed -i'' 's#^\\(extension=mysqli.so.*$\\)#;\1#g' /etc/php/php.ini  
RUN sed -i'' 's#^\\(extension=pdo_mysql.so.*$\\)#;\1#g' /etc/php/php.ini  
  
# Add extra script  
ADD assets/init /extra/init  
  
VOLUME ["/app"]  
EXPOSE 80  
CMD ["/init"]  

