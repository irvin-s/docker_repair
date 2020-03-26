FROM clojure:alpine

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app
COPY target/bcpoc-0.5.0-HOTASHELL-standalone.jar /usr/src/app/

EXPOSE 5000

CMD ["java", "-jar", "bcpoc-0.5.0-HOTASHELL-standalone.jar"]
