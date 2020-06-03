FROM java:7

RUN apt-get update -qq && apt-get install -y maven && apt-get clean

WORKDIR /code

ADD pom.xml /code/pom.xml
ADD setting.xml /code/setting.xml
ADD settings.xml /code/settings.xml
RUN \cp -rf /code/setting.xml /usr/share/maven/conf/
RUN \cp -rf /code/settings.xml /usr/share/maven/conf/
RUN ["mvn", "dependency:resolve"]
RUN ["mvn", "verify"]

# Adding source, compile and package into a fat jar
ADD src /code/src
RUN ["mvn", "package"]

CMD ["/usr/lib/jvm/java-7-openjdk-amd64/bin/java", "-jar", "target/worker-jar-with-dependencies.jar"]
