  
FROM java:8-jre  
#FROM mjava:8-jre  
MAINTAINER duanmx duanmxcode@sina.com  
  
ENV APP_NAME atwork-organization-bootstrap-2.0.0-GA  
ENV WORK_HOME /usr/organization  
ENV CONFIG_NAME config.sh  
  
COPY . $WORK_HOME  
WORKDIR $WORK_HOME  
  
#RUN tar zxvf $APP_NAME.tar.gz  
RUN apt-get update  
RUN apt-get install file -y  
RUN cp $WORK_HOME/$CONFIG_NAME $WORK_HOME/$APP_NAME/etc  
  
CMD ["/bin/bash","/usr/organization/start.sh"]  
  

