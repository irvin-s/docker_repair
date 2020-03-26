######################################################  
#  
# Agave Stats Dashboard  
# Tag: agaveapi/stats-dashboard  
#  
# This is the base image for Agave's PHP APIs. It  
# builds a minimal image with apache2 + php 5.5 + composer  
#  
# with support for auto-wiring database connections,  
# CORS support, and unified logging to standard out.  
#  
# https://bitbucket.org/agaveapi/stats-dashboard  
# http://agaveapi.co  
#  
######################################################  
  
FROM agaveapi/httpd:2.4  
MAINTAINER Rion Dooley <dooley@tacc.utexas.edu>  
  
ADD . /var/www/html  

