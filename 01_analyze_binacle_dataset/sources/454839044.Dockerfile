FROM goodrainapps/maven:jdk8-alpine
MAINTAINER guox <guox@goodrain.com>

# Caching Maven dependencies
COPY *.xml /app/
WORKDIR /app
RUN mvn -s maven-settings.xml  verify clean -Dmaven.repo.local=/tmp/cache --fail-never

# package
COPY . /app
RUN mvn -s maven-settings.xml -B -DskipTests=true -Dmaven.repo.local=/tmp/cache clean install

CMD ["java", "-Xmx200m", "-jar", "/app/target/monitoring.jar"]

EXPOSE 8989 8080
