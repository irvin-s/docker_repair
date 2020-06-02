# VERSION 1.0  
# DOCKER-VERSION 1.2.0  
# AUTHOR: Richard Lee <lifuzu@gmail.com>  
# DESCRIPTION: Devbase-ponte Image Container  
FROM dockerbase/devbase-nvm  
  
USER  root  
# Run dockerbase script  
ADD ponte.sh /dockerbase/  
RUN /dockerbase/ponte.sh  
  
# Add ponte into runit  
ADD build/runit/ponte /etc/service/ponte/run  

