# using ubuntu base image  
FROM ubuntu:14.04  
# Installing apache on ubuntu image  
RUN apt-get update  
RUN apt-get install -y apache2  
  
# Set the defalt port  
EXPOSE 80:80  
# Start apache application  
CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]  

