from debian  
run apt-get update && \  
apt-get install -y maven openjdk-7-jdk && \  
apt-get clean  
add pom.xml /srv/projet/  
workdir /srv/projet/  
run mvn install  
add src /srv/projet/src/  
expose 4242  
cmd mvn jetty:run  

