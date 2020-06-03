FROM openjdk:7-jdk-alpine

# update tar to support --strip-components
# add certificates to java key store
RUN apk --no-cache add tar ca-certificates \
  &&  for file in `ls /etc/ssl/certs/*`;do \
        keytool -importcert -storepass changeit -file $file -keystore $JAVA_HOME/jre/lib/security/cacerts -noprompt -alias $file; \
      done 

ENV MAVEN_HOME /usr/lib/mvn
RUN wget http://download.nus.edu.sg/mirror/apache/maven/maven-3/3.3.9/binaries/apache-maven-3.3.9-bin.tar.gz \
  && mkdir -p $MAVEN_HOME \
  && tar -zxvf apache-maven-3.3.9-bin.tar.gz -C $MAVEN_HOME --strip-components=1 \
  && rm apache-maven-3.3.9-bin.tar.gz

ENV PATH $PATH:$MAVEN_HOME/bin

COPY pom.xml /code/pom.xml
WORKDIR /code
RUN mvn dependency:resolve verify 

COPY src /code/src
RUN mvn package

# generate logs
# default = 100 logs, 20 ms delay, 5 threads
CMD ["java","-jar","target/log-generator-0.0.1-SNAPSHOT.jar","-n","1","-r","20","-t","5"]
