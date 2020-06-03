FROM clojure:alpine  
  
ADD src /app/src  
ADD project.clj /app  
  
WORKDIR /app  
RUN lein uberjar  
  
CMD ["/usr/bin/java", "-jar", "/app/target/takelist-latest-standalone.jar"]  

