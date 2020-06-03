FROM guacamole/guacamole  
COPY start.sh /newstart.sh  
RUN mv /newstart.sh /bin/start.sh \  
&& rm -rf /usr/local/tomcat/webapps/ROOT \  
&& ln -sf /opt/guacamole/guacamole.war /usr/local/tomcat/webapps/ROOT.war  
EXPOSE 8080  
CMD ["/opt/guacamole/bin/start.sh"]  

