from debian  
run apt-get update && \  
apt-get install -y maven openjdk-7-jdk && \  
apt-get clean  
add pom.xml /srv/develop-everywhere/  
workdir /srv/develop-everywhere/  
run mvn install  
add src /srv/develop-everywhere/src/  
expose 8080  
cmd mvn jetty:run  

