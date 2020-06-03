FROM phusion/baseimage:0.9.16  
MAINTAINER Neil Ellis hello@neilellis.me  
EXPOSE 80  
  
  
CMD ["/sbin/my_init"]  
  
ENV SLIMERJS_VERSION_M 0.9  
ENV SLIMERJS_VERSION_F 0.9.4  
ENV VERTX_VERSION 2.1.5  
# ENV PHANTOM_VERSION 1.9.8  
ENV SERVICE_KEY ABC123  
ENV SERVICE_ID 123  
ENV HOME /root  
ENV JAVA_HOME /usr/lib/jvm/java-8-oracle  
WORKDIR /root  
  
COPY build.sh /root/build.sh  
RUN chmod 755 /root/build.sh ; sleep 1; /root/build.sh  
  
  
############################### END OF INSTALLS
###############################  
  

