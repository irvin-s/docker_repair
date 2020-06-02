FROM clojure
MAINTAINER Matt Luongo (@mhluongo)

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app
ADD project.clj /usr/src/app/
RUN lein deps
COPY . /usr/src/app
ADD docker-config.clj /usr/src/app/resources/config.clj
RUN rm /usr/src/app/target/*.jar
RUN lein uberjar
RUN mv /usr/src/app/target/shale-0.3.0-SNAPSHOT-standalone.jar /srv/shale.jar

EXPOSE 5000
CMD ["java", "-jar", "/srv/shale.jar"]
