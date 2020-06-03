FROM maven  
  
RUN apt-get update  
RUN apt-get install rabbitmq-server -y  
  
WORKDIR /srv/  
  
ADD pom.xml /srv/  
RUN mvn -Dmaven.repo.local=lib clean install || true  
RUN apt-get install graphviz -y  
ADD launch.sh /srv/  
  
RUN chmod +x launch.sh  
CMD /bin/bash launch.sh  
  
ADD src /srv/src  
  
RUN mvn -Dmaven.repo.local=lib install  
  
EXPOSE 8080 80 9090 15672  

