FROM tomcat:8.0-jre8  
  
RUN mkdir -p /var/lib/jnuget/Packages \  
&& rm -rf /usr/local/tomcat/webapps/ROOT  
  
COPY jnuget-0.8.2-SNAPSHOT.war /usr/local/tomcat/webapps/ROOT.war  
COPY jnuget.config.xml /var/lib/jnuget/jnuget.config.xml  
COPY jnuget.users.xml /var/lib/jnuget/jnuget.users.xml  
  
ENV NUGET_HOME /var/lib/jnuget  
  
EXPOSE 8080  
  
VOLUME ["/var/lib/jnuget","/usr/local/tomcat/logs","/usr/local/tomcat/conf"]  

