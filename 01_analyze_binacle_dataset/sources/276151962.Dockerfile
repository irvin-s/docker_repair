FROM clojure:lein-2.7.1-alpine

COPY . /usr/src/hawkthorne/
WORKDIR /usr/src/hawkthorne/

RUN lein uberjar
RUN mv ./target/hawkthorne.jar .
RUN lein clean

EXPOSE 8080

CMD ["java", "-jar", "hawkthorne.jar"]
