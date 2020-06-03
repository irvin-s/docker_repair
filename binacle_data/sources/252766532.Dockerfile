FROM clojure:lein-2.5.3  
RUN mkdir /app  
WORKDIR /app  
COPY project.clj .  
  
RUN lein with-profile production deps  
  
WORKDIR /root  
RUN rm -r /app  

