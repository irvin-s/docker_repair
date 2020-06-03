FROM maven:3-jdk-8  
WORKDIR /root  
  
#Add Necessary Files and Environment settings  
ADD pom.xml /root/pom.xml  
  
RUN mvn dependency:go-offline clean  
  
#Expose Rest Service Port  
EXPOSE 24242  
ENTRYPOINT ["/bin/bash"]

