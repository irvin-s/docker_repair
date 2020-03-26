FROM clojure  
  
# Install  
COPY . /app  
WORKDIR /app  
VOLUME /app/config  
RUN lein deps  
  
# Test  
RUN lein test  
  
# Build  
RUN lein uberjar  
  
# Run  
CMD java -jar target/correo-*-standalone.jar config/email.edn 80  
EXPOSE 80  

