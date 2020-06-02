FROM cazcade/easydeploy-mvn-base  
WORKDIR /usr/local/  
RUN wget http://dl.bintray.com/vertx/downloads/vert.x-2.1.2.tar.gz  
RUN tar -zxvf vert.x-2.1.2.tar.gz  
RUN ln -s /usr/local/vert.x-2.1.2 /usr/local/vertx  
  
WORKDIR /tmp  
ADD pom.xml /tmp/  
RUN mvn dependency:resolve  
ADD src /tmp/src  
RUN mvn clean install -Dmaven.test.skip  
RUN rm -rf /tmp/*  
  
ONBUILD WORKDIR /app  
ONBUILD ADD pom.xml /app/  
ONBUILD RUN mvn dependency:resolve  
ONBUILD ADD src /app/src  
ONBUILD RUN ls -la /app  
ONBUILD RUN mvn clean install -Dmaven.test.skip  
ONBUILD ADD run.sh /run.sh  
ONBUILD RUN chmod 755 /run.sh  
CMD "/run.sh"  

