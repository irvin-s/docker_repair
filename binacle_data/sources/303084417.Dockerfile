FROM maven:3-jdk-8 

WORKDIR /code

# Prepare by downloading dependencies
ADD pom.xml /code/pom.xml
RUN ["mvn", "dependency:resolve"]

# Add source, compile and package
ADD src /code/src
RUN ["mvn", "-DfinalName=owl", "package"]

# Add the docker-compose friendly config
ADD docker/application.properties /code/application.properties

EXPOSE 8090
CMD ["/usr/bin/java", "-jar", "target/owl.jar", "--spring.config.location=/code/application.properties"]
