FROM dockerfile/java:oracle-java8  
  
RUN apt-get update  
RUN apt-get install -y maven postgresql-client  
  
WORKDIR /pfennig  
  
# Prepare by downloading dependencies  
ADD pom.xml /pfennig/pom.xml  
ADD pfennig-create.sql /pfennig/pfennig-create.sql  
ADD pfennig-drop.sql /pfennig/pfennig-drop.sql  
  
RUN ["mvn", "dependency:resolve"]  
RUN ["mvn", "verify"]  
  
ADD src /pfennig/src  
RUN ["mvn", "package"]  
  
RUN mkdir -p /pfennig/wallets  
  
EXPOSE 4567  
ADD ./start.sh /pfennig/start.sh  
RUN chmod +x /pfennig/start.sh  
  
CMD ["/pfennig/start.sh"]  
#CMD ["java", "-jar", "target/pfennig-jar-with-dependencies.jar"]  

