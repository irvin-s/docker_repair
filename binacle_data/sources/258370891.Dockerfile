FROM clojure
COPY  target/boards-io-standalone.jar /boards-io-standalone.jar 
EXPOSE 9082
CMD ["java", "-jar", "/boards-io-standalone.jar"]
