FROM goodrainapps/maven:jdk8-alpine
MAINTAINER guox <guox@goodrain.com>

# Caching Maven dependencies
COPY *.xml /app/
WORKDIR /app
RUN mvn -s maven-settings.xml  verify clean -Dmaven.repo.local=/tmp/cache --fail-never

# package
COPY . /app
RUN mvn -s maven-settings.xml -B -DskipTests=true -Dmaven.repo.local=/tmp/cache clean install

ENV PORT=4000
CMD ["java", "-Xmx200m","-Dserver.port=${PORT}","-jar", "/app/target/gateway.jar"]

EXPOSE 4000