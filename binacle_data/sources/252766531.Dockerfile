FROM clojure:lein-2.5.3  
COPY resources /app/resources  
COPY src /app/src  
COPY project.clj /app/  
  
WORKDIR /app  
  
RUN lein with-profile production deps  
  
EXPOSE 80  
CMD ["lein", "with-profile", "production", "trampoline", "run"]  

