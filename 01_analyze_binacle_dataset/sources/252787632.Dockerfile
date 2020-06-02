FROM guligo/jdk-maven-ant-tomcat  
COPY . /  
RUN mvn package  
# move the .war file into the webapp directory of your Tomcat  
RUN mv /target/dockerauth-1.0.war /etc/tomcat-8.0.24/webapps  
# Enable SSL. .keystore contains a self-signed cert. THIS IS ONLY FOR TESTING.  
COPY etc/.keystore /root/  
COPY etc/server.xml etc/catalina.properties /etc/tomcat-8.0.24/conf/  

