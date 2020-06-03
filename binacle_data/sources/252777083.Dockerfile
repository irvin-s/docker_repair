FROM rawmind/alpine-revealjs:3.6.0-0  
MAINTAINER Raul Sanchez <rawmind@gmail.com>  
  
# Adding content into ${SERVICE_SITE}  
ADD slides ${SERVICE_SITE}/slides/  
ADD index.html ${SERVICE_SITE}/  
  
# Setting files owner  
USER root  
RUN chown -R ${SERVICE_USER}:${SERVICE_GROUP} ${SERVICE_SITE}  
USER ${SERVICE_USER}  

