###  
# Agave Live Docs  
# Container for running the pre-generated Agave Live Docs  
#  
# Build: docker build -t live-docs .  
# Run: docker run -p 80:80 -p 443:443 -n live-docs live-docs  
#  
# https://bitbucket.org/agaveapi/live-docs  
###  
  
FROM agaveapi/httpd:2.4  
MAINTAINER dooley@tacc.utexas.edu  
  
ADD ./dist /var/www/html  
ADD ./docker_entrypoint.sh /docker_entrypoint.sh  

