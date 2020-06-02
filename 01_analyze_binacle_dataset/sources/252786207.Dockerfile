from java  
  
RUN mkdir /gerrit /data  
WORKDIR /data  
VOLUME /data  
ENV GERRIT_VERSION 2.11.4  
ENV GERRIT_AUTH_TYPE OPENID  
ENV GERRIT_PLUGINS ""  
COPY runit.sh /gerrit/runit.sh  
COPY etc /gerrit/etc  
RUN chmod +x /gerrit/runit.sh  
EXPOSE 8080  
EXPOSE 29418  
CMD /gerrit/runit.sh  

