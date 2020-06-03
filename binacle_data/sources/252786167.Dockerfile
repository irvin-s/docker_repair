FROM java:8-jre  
MAINTAINER Dmitry Zapashchikov <dmitriiz@hotmail.com>  
ADD docker-entrypoint.sh /  
ADD application.jar /  
ENV APP_NAME app  
ENV APP_TZ UTC  
ENV APP_LANG en  
ENV APP_COUNTRY US  
EXPOSE 8080  
VOLUME ["/tmp"]  
ENTRYPOINT ["/docker-entrypoint.sh"]  

