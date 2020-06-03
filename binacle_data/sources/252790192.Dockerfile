FROM tomcat:7.0-jre7-alpine  
ENV NAME HARDTC  
ENV TC_USER tomcat  
ENV TC_UID 6060  
WORKDIR /usr/local/tomcat  
COPY ["./data", "/data"]  
COPY ["./overrides", "/data/overrides"]  
RUN ["/bin/sh", "/data/build.sh"]  
EXPOSE 8080/tcp  
ENTRYPOINT ["/usr/bin/dumb-init", "--"]  
CMD ["/bin/sh", "/data/init.sh"]  
  

