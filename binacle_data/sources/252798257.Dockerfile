from debian  
run apt-get update && \  
apt-get install -y maven openjdk-7-jdk && \  
apt-get clean  
add Serveur/pom.xml /srv/server/  
workdir /srv/server/  
run mvn install  
add Serveur/src /srv/server/src/  
expose 8080  
cmd mvn jetty:run  

