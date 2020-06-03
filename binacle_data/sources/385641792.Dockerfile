FROM openjdk:8-jdk

# Install maven
RUN apt-get update
RUN apt-get install -y maven

WORKDIR /code

# Prepare by downloading dependencies
ADD pom.xml /code/pom.xml
RUN ["mvn", "dependency:resolve", "-U"]
RUN ["mvn", "verify"]

# Adding source, compile and package into a fat jar
ADD src /code/src
RUN ["mvn", "package", "-DskipTest=True", "-Dmaven.javadoc.skip=true", "-Dmaven.test.skip=true", "--offline"]

EXPOSE 4458
# CMD ["ls", "-la", "target/"]
ENTRYPOINT ["/usr/lib/jvm/java-8-openjdk-amd64/bin/java", "-jar", "target/pbft-jar-with-dependencies.jar"]
