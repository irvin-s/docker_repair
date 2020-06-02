from debian  
run apt-get update && \  
apt-get install -y maven openjdk-7-jdk && \  
apt-get clean  
add pom.xml /srv/jersey-skeleton/  
workdir /srv/jersey-skeleton/  
run mvn install  
add src /srv/jersey-skeleton/src/  
expose 8080  
cmd mvn jetty:run  

